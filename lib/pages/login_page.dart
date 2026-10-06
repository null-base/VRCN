import 'package:vrchat/utils/app_icons.dart';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vrchat/controllers/external_link_controller.dart';
import 'package:vrchat/controllers/login_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';
import 'package:vrchat/widgets/two_factor_code_input.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _twoFactorCodeController = TextEditingController();
  final _localAuth = LocalAuthentication();
  var _isLoading = false;
  String? _errorMessage;
  var _obscurePassword = true;
  var _showTwoFactorAuth = false;
  var _canUseBiometricLogin = false;

  // ログイン状態を保存するかどうか
  var _rememberLogin = true;

  @override
  void initState() {
    super.initState();
    _loadBiometricAvailability();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _twoFactorCodeController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await ref
          .read(loginControllerProvider)
          .login(
            username: _usernameController.text,
            password: _passwordController.text,
            rememberLogin: _rememberLogin,
          );

      if (!mounted) return;

      switch (result.status) {
        case LoginFlowStatus.success:
          context.go('/');
        case LoginFlowStatus.requiresTwoFactor:
          setState(() {
            _showTwoFactorAuth = true;
          });
        case LoginFlowStatus.failure:
          setState(() {
            _errorMessage = t.login.errorLoginFailed;
          });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = t.common.error(error: e.toString());
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadBiometricAvailability() async {
    try {
      final storage = ref.read(authStorageProvider);
      final credentials = await storage.getCredentials();
      final hasCredentials =
          await storage.getRememberLogin() &&
          credentials.username != null &&
          credentials.password != null &&
          credentials.username!.isNotEmpty &&
          credentials.password!.isNotEmpty;
      if (!hasCredentials) {
        if (mounted) setState(() => _canUseBiometricLogin = false);
        return;
      }
      final canUseBiometrics = await _localAuth.canCheckBiometrics;

      if (!mounted) return;
      setState(() {
        _canUseBiometricLogin = canUseBiometrics;
      });
    } on PlatformException {
      if (!mounted) return;
      setState(() {
        _canUseBiometricLogin = false;
      });
    }
  }

  Future<void> _loginWithBiometrics() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: t.login.biometricReason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );

      if (!authenticated) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      final credentials = await ref.read(authStorageProvider).getCredentials();
      final username = credentials.username;
      final password = credentials.password;
      if (username == null || password == null) {
        throw StateError(t.login.savedLoginMissing);
      }

      final result = await ref
          .read(loginControllerProvider)
          .login(username: username, password: password, rememberLogin: true);

      if (!mounted) return;

      switch (result.status) {
        case LoginFlowStatus.success:
          context.go('/');
        case LoginFlowStatus.requiresTwoFactor:
          _usernameController.text = username;
          _passwordController.text = password;
          setState(() {
            _showTwoFactorAuth = true;
          });
        case LoginFlowStatus.failure:
          setState(() {
            _errorMessage = t.login.errorLoginFailed;
          });
      }
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = t.common.error(error: e.message ?? e.code);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = t.common.error(error: e.toString());
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyTwoFactorCode() async {
    if (_twoFactorCodeController.text.isEmpty) {
      setState(() {
        _errorMessage = t.login.errorEmpty2fa;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await ref
          .read(loginControllerProvider)
          .verifyTwoFactorCode(
            code: _twoFactorCodeController.text,
            username: _usernameController.text,
            password: _passwordController.text,
            rememberLogin: _rememberLogin,
          );

      if (!mounted) return;

      switch (result.status) {
        case LoginFlowStatus.success:
          context.go('/');
        case LoginFlowStatus.requiresTwoFactor:
          break;
        case LoginFlowStatus.failure:
          setState(() {
            _errorMessage = t.login.error2faFailed;
          });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = t.common.error(error: e.toString());
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _setTwoFactorCodeDigits(String value) {
    final code = ref.read(loginControllerProvider).extractTwoFactorCode(value);
    final normalizedCode = code ?? '';
    _twoFactorCodeController.value = TextEditingValue(
      text: normalizedCode,
      selection: TextSelection.collapsed(offset: normalizedCode.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final subtitleColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // タイトル
                      Text(
                        _showTwoFactorAuth
                            ? t.login.twoFactorTitle
                            : t.common.title,
                        style: GoogleFonts.notoSans(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _showTwoFactorAuth
                            ? t.login.twoFactorSubtitle
                            : t.login.subtitle,
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: subtitleColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32),

                      // ログインフォーム または 2FA フォーム
                      if (!_showTwoFactorAuth) ...[
                        _buildTextField(
                          controller: _usernameController,
                          labelText: t.login.email,
                          hintText: t.login.emailHint,
                          prefixIcon: AppIcons.person_outline_rounded,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return t.login.errorEmptyEmail;
                            }
                            return null;
                          },
                          autofillHints: const [
                            AutofillHints.username,
                            AutofillHints.email,
                          ],
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: _passwordController,
                          labelText: t.common.password,
                          hintText: t.login.passwordHint,
                          prefixIcon: AppIcons.lock_outline_rounded,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? AppIcons.visibility_rounded
                                  : AppIcons.visibility_off_rounded,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return t.login.errorEmptyPassword;
                            }
                            return null;
                          },
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            if (!_isLoading) _login();
                          },
                        ),

                        const SizedBox(height: 16),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              externalLinkController.launch(
                                'https://vrchat.com/home/password',
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: primaryColor,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              t.login.forgotPassword,
                              style: GoogleFonts.notoSans(fontSize: 14),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              externalLinkController.launch(
                                'https://vrchat.com/home/register',
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: primaryColor,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              t.login.createAccount,
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ログイン状態を保存するオプション
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberLogin,
                              onChanged: (value) {
                                setState(() {
                                  _rememberLogin = value ?? true;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                            Text(
                              t.login.rememberMe,
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: subtitleColor,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ログインボタン
                        _buildGradientButton(
                          onPressed: _isLoading ? null : _login,
                          text: _isLoading ? t.login.loggingIn : t.common.login,
                          isLoading: _isLoading,
                        ),
                        if (_canUseBiometricLogin) ...[
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: _isLoading ? null : _loginWithBiometrics,
                            icon: const Icon(
                              AppIcons.fingerprint_rounded,
                            ),
                            label: Text(t.login.biometricLogin),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: primaryColor,
                              side: BorderSide(color: primaryColor),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ] else ...[
                        // 二段階認証のUI
                        Text(
                          t.login.twoFactorInstruction,
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            color: subtitleColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 36),

                        // OTP入力フィールド
                        _buildOtpInputField(t),
                        const SizedBox(height: 40),

                        // 認証ボタン
                        _buildGradientButton(
                          onPressed: _isLoading ? null : _verifyTwoFactorCode,
                          text: _isLoading ? t.login.verifying : t.login.verify,
                          isLoading: _isLoading,
                        ),

                        const SizedBox(height: 16),

                        // ログイン画面に戻るボタン
                        Center(
                          child: TextButton.icon(
                            onPressed: !_isLoading
                                ? () {
                                    setState(() {
                                      _showTwoFactorAuth = false;
                                      _errorMessage = null;
                                    });
                                  }
                                : null,
                            icon: const Icon(
                              AppIcons.arrow_back_rounded,
                            ),
                            label: Text(
                              t.login.backToLogin,
                              style: GoogleFonts.notoSans(),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: primaryColor,
                            ),
                          ),
                        ),
                      ],

                      // エラーメッセージ
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.red.shade900.withAlpha(50)
                                : Colors.red.withAlpha(25),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.red.shade800
                                  : Colors.red.withAlpha(75),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                AppIcons.error_outline_rounded,
                                color: isDarkMode
                                    ? Colors.red.shade300
                                    : Colors.red,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: isDarkMode
                                        ? Colors.red.shade200
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // OTP入力フィールドを構築
  Widget _buildOtpInputField(Translations t) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwoFactorCodeInput(
          controller: _twoFactorCodeController,
          enabled: !_isLoading,
          semanticLabel: t.login.twoFactorCodeHint,
          onCompleted: (_) {
            if (!_isLoading) _verifyTwoFactorCode();
          },
        ),

        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: TextButton.icon(
              onPressed: _pasteFromClipboard,
              icon: const Icon(AppIcons.content_paste_rounded),
              label: Text(t.login.paste, style: GoogleFonts.notoSans()),
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 主要アクションはプラットフォームのボタンを使う。
  Widget _buildGradientButton({
    required VoidCallback? onPressed,
    required String text,
    required bool isLoading,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: AdaptiveButton.child(
        onPressed: onPressed,
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }

  // カスタムテキストフィールドを構築
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    required String? Function(String?) validator,
    bool obscureText = false,
    Widget? suffixIcon,
    List<String> autofillHints = const [],
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          enabled: !_isLoading,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              prefixIcon,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          validator: validator,
        ),
      ],
    );
  }

  // クリップボードからのペースト機能を追加
  Future<void> _pasteFromClipboard() async {
    // クリップボードからテキストを取得
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final otpCode = ref
        .read(loginControllerProvider)
        .extractTwoFactorCode(clipboardData?.text);
    if (otpCode == null) return;

    setState(() {
      _setTwoFactorCodeDigits(otpCode);
    });

    if (otpCode.length == 6 && mounted) {
      await _verifyTwoFactorCode();
    }
  }
}
