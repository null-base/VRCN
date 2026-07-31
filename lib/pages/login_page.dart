import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vrchat/controllers/external_link_controller.dart';
import 'package:vrchat/controllers/login_controller.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _twoFactorCodeController = TextEditingController();
  final List<String> _twoFactorCodeValue = List.filled(6, '');
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final _hiddenController = TextEditingController();
  final _hiddenFocusNode = FocusNode();
  final _localAuth = LocalAuthentication();
  var _isLoading = false;
  String? _errorMessage;
  var _obscurePassword = true;
  var _showTwoFactorAuth = false;
  var _canUseBiometricLogin = false;

  // ログイン状態を保存するかどうか
  var _rememberLogin = true;

  // アニメーション用コントローラー
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラーの初期化
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    // アニメーション開始
    _animationController.forward();
    _loadBiometricAvailability();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _twoFactorCodeController.dispose();
    _hiddenController.dispose();
    for (final node in _focusNodes) {
      node.dispose();
    }
    _hiddenFocusNode.dispose();
    _animationController.dispose();
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
          _animationController.reset();
          await _animationController.forward();
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
      final canUseBiometrics = await _localAuth.canCheckBiometrics;

      if (!mounted) return;
      setState(() {
        _canUseBiometricLogin = hasCredentials && canUseBiometrics;
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
        localizedReason: 'Authenticate to use your saved VRChat login.',
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
        throw StateError('Saved login is missing.');
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
          _animationController.reset();
          await _animationController.forward();
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
    for (var i = 0; i < _twoFactorCodeValue.length; i++) {
      _twoFactorCodeValue[i] = i < value.length ? value[i] : '';
    }
    _twoFactorCodeController.text = _twoFactorCodeValue.join();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final size = MediaQuery.of(context).size;

    // テキストカラーをモードに応じて設定
    final subtitleColor = isDarkMode ? Colors.grey[300] : Colors.grey[600];

    return Scaffold(
      body: Stack(
        children: [
          // グラデーション背景
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [Colors.grey[900]!, Colors.black, Colors.grey[850]!]
                    : [
                        Colors.blue[50]!,
                        Colors.indigo[50]!,
                        Colors.purple[50]!,
                      ],
              ),
            ),
          ),

          // あのめあ
          Center(
            child: Image.asset(
              Assets.images.standing.path,
              height: size.height * 0.85,
              fit: BoxFit.contain,
            ),
          ),

          // ログインフォーム
          SafeArea(
            child: Align(
              alignment: const Alignment(0, 0.3),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      width: min(450, size.width * 0.85),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.black.withValues(alpha: 0.75)
                            : Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.05),
                        ),
                      ),
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
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.white
                                      : secondaryColor,
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
                                  prefixIcon: Icons.person_outline_rounded,
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
                                  prefixIcon: Icons.lock_outline_rounded,
                                  obscureText: _obscurePassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
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
                                  text: _isLoading
                                      ? t.login.loggingIn
                                      : t.common.login,
                                  isLoading: _isLoading,
                                ),
                                if (_canUseBiometricLogin) ...[
                                  const SizedBox(height: 12),
                                  OutlinedButton.icon(
                                    onPressed: _isLoading
                                        ? null
                                        : _loginWithBiometrics,
                                    icon: const Icon(
                                      Icons.fingerprint_rounded,
                                    ),
                                    label: const Text('Login with biometrics'),
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
                                  onPressed: _isLoading
                                      ? null
                                      : _verifyTwoFactorCode,
                                  text: _isLoading
                                      ? t.login.verifying
                                      : t.login.verify,
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
                                            _animationController.reset();
                                            _animationController.forward();
                                          }
                                        : null,
                                    icon: const Icon(Icons.arrow_back_rounded),
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
                                        Icons.error_outline_rounded,
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
            ),
          ),
        ],
      ),
    );
  }

  // OTP入力フィールドを構築
  Widget _buildOtpInputField(Translations t) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Offstage(
          child: TextField(
            controller: _hiddenController,
            focusNode: _hiddenFocusNode,
            keyboardType: TextInputType.number,
            autofillHints: const [AutofillHints.oneTimeCode],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _setTwoFactorCodeDigits(value);
                });

                if (value.length == 6) {
                  _verifyTwoFactorCode();
                } else if (value.isNotEmpty) {
                  _focusNodes[value.length - 1].requestFocus();
                }

                _hiddenController.clear();
              }
            },
          ),
        ),

        GestureDetector(
          onTap: _hiddenFocusNode.requestFocus,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(isDarkMode ? 75 : 13),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, _buildDigitBox),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: TextButton.icon(
              onPressed: _pasteFromClipboard,
              icon: const Icon(Icons.content_paste_rounded),
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

  // OTP入力の各桁用ボックス
  Widget _buildDigitBox(int index) {
    final hasValue = _twoFactorCodeValue[index].isNotEmpty;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: hasValue
            ? primaryColor.withAlpha(isDarkMode ? 75 : 25)
            : (isDarkMode ? Colors.grey[700] : Colors.grey[100]),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasValue
              ? primaryColor
              : (isDarkMode ? Colors.grey[600]! : Colors.grey.withAlpha(75)),
          width: hasValue ? 2 : 1,
        ),
      ),
      child: TextField(
        focusNode: _focusNodes[index],
        enabled: !_isLoading,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        controller: TextEditingController(text: _twoFactorCodeValue[index]),
        style: GoogleFonts.robotoMono(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : primaryColor,
        ),
        decoration: const InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          setState(() {
            _twoFactorCodeValue[index] = value;
            _twoFactorCodeController.text = _twoFactorCodeValue.join();
          });

          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }

          if (_twoFactorCodeController.text.length == 6) {
            _verifyTwoFactorCode();
          }
        },
      ),
    );
  }

  // グラデーションボタンを構築
  Widget _buildGradientButton({
    required VoidCallback? onPressed,
    required String text,
    required bool isLoading,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: onPressed == null
              ? [Colors.grey, Colors.grey.shade400]
              : [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(75),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDarkMode ? 75 : 13),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        autofillHints: autofillHints,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        enabled: !_isLoading,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey[600]! : Colors.grey.withAlpha(75),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.redAccent : Colors.red,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          labelStyle: GoogleFonts.notoSans(
            color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
          ),
          hintStyle: GoogleFonts.notoSans(
            color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
          ),
          floatingLabelStyle: GoogleFonts.notoSans(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: GoogleFonts.notoSans(
          fontSize: 16,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
        validator: validator,
      ),
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
