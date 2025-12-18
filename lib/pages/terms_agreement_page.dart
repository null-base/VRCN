import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/first_launch_utils.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';

class TermsAgreementPage extends ConsumerStatefulWidget {
  const TermsAgreementPage({super.key});

  @override
  ConsumerState<TermsAgreementPage> createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends ConsumerState<TermsAgreementPage>
    with TickerProviderStateMixin {
  var _termsAccepted = false;
  var _privacyAccepted = false;
  var _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: DecoratedBox(
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
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),

                            // アプリロゴとタイトル
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withValues(alpha: 0.3),
                                          blurRadius: 20,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        Assets.icons.vrcn.path,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: AppTheme.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Icon(
                                              Icons.vrpano,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    t.termsAgreement.welcomeTitle,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isDarkMode
                                              ? Colors.white
                                              : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    t.termsAgreement.welcomeMessage,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          isDarkMode
                                              ? Colors.grey[300]
                                              : Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 48),

                            // 利用規約とプライバシーポリシーのチェックボックス
                            _buildAgreementSection(isDarkMode, t),

                            const SizedBox(height: 32),

                            // 注意事項
                            _buildNoticeSection(isDarkMode, t),
                          ],
                        ),
                      ),
                    ),

                    // 同意ボタン
                    _buildActionButtons(isDarkMode, t),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgreementSection(bool isDarkMode, Translations t) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? Colors.black.withValues(alpha: .3)
                : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isDarkMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          // 利用規約
          _buildCheckboxTile(
            title: t.termsAgreement.termsTitle,
            subtitle: t.termsAgreement.termsSubtitle,
            value: _termsAccepted,
            onChanged:
                (value) => setState(() => _termsAccepted = value ?? false),
            onLinkTap:
                () => UrlLauncherUtils.launchURL(
                  'https://null-base.com/vrcn/terms-of-service',
                ),
            isDarkMode: isDarkMode,
            t: t,
          ),

          const SizedBox(height: 16),

          // プライバシーポリシー
          _buildCheckboxTile(
            title: t.termsAgreement.privacyTitle,
            subtitle: t.termsAgreement.privacySubtitle,
            value: _privacyAccepted,
            onChanged:
                (value) => setState(() => _privacyAccepted = value ?? false),
            onLinkTap:
                () => UrlLauncherUtils.launchURL(
                  'https://null-base.com/vrcn/privacy-policy/',
                ),
            isDarkMode: isDarkMode,
            t: t,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required VoidCallback onLinkTap,
    required bool isDarkMode,
    required Translations t,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primaryColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      t.termsAgreement.agreeTerms(title: title),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onLinkTap,
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: Text(
                      t.termsAgreement.checkContent,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoticeSection(bool isDarkMode, Translations t) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.amber[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              t.termsAgreement.notice,
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? Colors.amber[200] : Colors.amber[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isDarkMode, Translations t) {
    final canProceed = _termsAccepted && _privacyAccepted;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: canProceed && !_isLoading ? _handleAccept : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              elevation: canProceed ? 8 : 0,
            ),
            child:
                _isLoading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Text(
                      t.common.agree,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _isLoading ? null : _handleDecline,
          child: Text(
            t.common.decline,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAccept() async {
    setState(() => _isLoading = true);

    try {
      // 利用規約への同意を記録
      await FirstLaunchUtils.acceptTerms();

      // 初回起動完了を記録
      await FirstLaunchUtils.setFirstLaunchCompleted();

      if (mounted) {
        // ログイン画面に遷移
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.common.error(error: e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleDecline() {
    // アプリを終了
    SystemNavigator.pop();
  }
}
