import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/router/app_router.dart';

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
  var _isLoading = false;
  String? _errorMessage;
  var _obscurePassword = true;
  var _showTwoFactorAuth = false;

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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // アニメーション開始
    _animationController.forward();

    // デバッグモードの場合は環境変数から認証情報を読み込む
    if (kDebugMode) {
      _loadCredentialsFromEnv();
    }
  }

  // 環境変数から認証情報を読み込む
  void _loadCredentialsFromEnv() {
    try {
      final username = dotenv.env['VRCHAT_USERNAME'];
      final password = dotenv.env['VRCHAT_PASSWORD'];

      if (username != null && username.isNotEmpty) {
        _usernameController.text = username;
      }

      if (password != null && password.isNotEmpty) {
        _passwordController.text = password;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('環境変数からの認証情報読み込みに失敗しました: $e');
      }
    }
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
    final auth = ref.watch(vrchatAuthProvider).value;
    if (auth == null || !(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final (loginSuccess, loginFailure) = await auth.login(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (loginSuccess == null) {
        // ログイン失敗
        setState(() {
          _errorMessage = t.login.errorLoginFailed;
        });
      } else if (loginSuccess.data.requiresTwoFactorAuth) {
        // 二段階認証が必要な場合
        setState(() {
          _showTwoFactorAuth = true;
        });
        // 新しい画面のアニメーションをリセットして再生
        _animationController.reset();
        await _animationController.forward();

        // 自動OTP入力を試行
        // _tryAutoOtpInput();
      } else {
        if (_rememberLogin) {
          // ログイン情報を保存
          final authStorage = ref.read(authStorageProvider);
          await authStorage.saveCredentials(
            _usernameController.text,
            _passwordController.text,
          );
        }
        await _handleLoginSuccess();
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
      final auth = ref.watch(vrchatAuthProvider).value;
      if (auth == null) return;
      final (twoFactorSuccess, twoFactorFailure) = await auth.verify2fa(
        _twoFactorCodeController.text,
      );

      if (!mounted) return;

      if (twoFactorFailure == null) {
        // ログイン成功
        await _handleLoginSuccess();
      } else {
        // ログイン失敗
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

  // ログイン成功時の処理
  Future<void> _handleLoginSuccess() async {
    // 認証状態を更新
    ref.read(authRefreshProvider.notifier).state++;

    try {
      // ユーザー情報を先に取得してキャッシュしておく
      await ref.read(currentUserProvider.future);
    } catch (e) {
      debugPrint('ログイン後のユーザー情報取得でエラー: $e');
      // エラーがあっても続行（後でリトライする）
    }

    // ホーム画面に遷移
    if (mounted) {
      context.go('/');
    }
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
                colors:
                    isDarkMode
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
                        color:
                            isDarkMode
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
                          color:
                              isDarkMode
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.05),
                          width: 1,
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
                                  color:
                                      isDarkMode
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
                                      final url = Uri.parse(
                                        'https://vrchat.com/home/password',
                                      );
                                      launchUrl(url);
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
                                      final url = Uri.parse(
                                        'https://vrchat.com/home/register',
                                      );
                                      launchUrl(url);
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
                                  text:
                                      _isLoading
                                          ? t.login.loggingIn
                                          : t.common.login,
                                  isLoading: _isLoading,
                                ),
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
                                  onPressed:
                                      _isLoading ? null : _verifyTwoFactorCode,
                                  text:
                                      _isLoading
                                          ? t.login.verifying
                                          : t.login.verify,
                                  isLoading: _isLoading,
                                ),

                                const SizedBox(height: 16),

                                // ログイン画面に戻るボタン
                                Center(
                                  child: TextButton.icon(
                                    onPressed:
                                        !_isLoading
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
                                    color:
                                        isDarkMode
                                            ? Colors.red.shade900.withAlpha(50)
                                            : Colors.red.withAlpha(25),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          isDarkMode
                                              ? Colors.red.shade800
                                              : Colors.red.withAlpha(75),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error_outline_rounded,
                                        color:
                                            isDarkMode
                                                ? Colors.red.shade300
                                                : Colors.red,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          _errorMessage!,
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color:
                                                isDarkMode
                                                    ? Colors.red.shade200
                                                    : Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              // デバッグ情報
                              if (kDebugMode && !_showTwoFactorAuth) ...[
                                const SizedBox(height: 32),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(5),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black.withAlpha(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.bug_report_rounded,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'デバッグモード：.env認証情報を使用',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 12,
                                          color: Colors.grey,
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
                  for (var i = 0; i < 6; i++) {
                    if (i < value.length) {
                      _twoFactorCodeValue[i] = value[i];
                    } else {
                      _twoFactorCodeValue[i] = '';
                    }
                  }
                });

                if (value.length == 6) {
                  _twoFactorCodeController.text = value;
                  _verifyTwoFactorCode();
                } else if (value.isNotEmpty) {
                  _focusNodes[value.length - 1].requestFocus();
                }

                Future.delayed(Duration.zero, _hiddenController.clear);
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
        color:
            hasValue
                ? primaryColor.withAlpha(isDarkMode ? 75 : 25)
                : (isDarkMode ? Colors.grey[700] : Colors.grey[100]),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              hasValue
                  ? primaryColor
                  : (isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey.withAlpha(75)),
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
          if (value.isNotEmpty) {
            _twoFactorCodeValue[index] = value;
            if (index < 5) {
              FocusScope.of(context).nextFocus();
            } else {
              if (_twoFactorCodeValue.join().length == 6) {
                _twoFactorCodeController.text = _twoFactorCodeValue.join();
                _verifyTwoFactorCode();
              }
            }
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
          colors:
              onPressed == null
                  ? [Colors.grey, Colors.grey.shade400]
                  : [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
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
        child:
            isLoading
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
              width: 1,
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
              width: 1,
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
    final text = clipboardData?.text;

    if (text != null && text.isNotEmpty) {
      // 数字のみを抽出
      final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

      if (digitsOnly.isNotEmpty) {
        // 各桁に値を設定
        setState(() {
          for (var i = 0; i < 6; i++) {
            if (i < digitsOnly.length) {
              _twoFactorCodeValue[i] = digitsOnly[i];
            } else {
              _twoFactorCodeValue[i] = '';
            }
          }
        });

        // 6桁のコードを変数に設定
        if (digitsOnly.length >= 6) {
          final otpCode = digitsOnly.substring(0, 6);
          _twoFactorCodeController.text = otpCode;

          // 少し遅延してから認証処理を実行
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) _verifyTwoFactorCode();
          });
        }
      }
    }
  }
}
