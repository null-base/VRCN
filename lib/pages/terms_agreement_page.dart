import 'package:vrchat/utils/app_icons.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vrchat/controllers/external_link_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/utils/first_launch_utils.dart';

class TermsAgreementPage extends ConsumerStatefulWidget {
  const TermsAgreementPage({super.key});

  @override
  ConsumerState<TermsAgreementPage> createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends ConsumerState<TermsAgreementPage> {
  var _termsAccepted = false;
  var _privacyAccepted = false;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 36),

                          // アプリロゴとタイトル
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  t.termsAgreement.welcomeTitle,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  t.termsAgreement.welcomeMessage,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDarkMode
                                        ? Colors.grey[300]
                                        : Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 36),

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
    );
  }

  Widget _buildAgreementSection(bool isDarkMode, Translations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          // 利用規約
          _buildCheckboxTile(
            title: t.termsAgreement.termsTitle,
            subtitle: t.termsAgreement.termsSubtitle,
            value: _termsAccepted,
            onChanged: (value) =>
                setState(() => _termsAccepted = value ?? false),
            onLinkTap: () => externalLinkController.launch(
              'https://null-base.com/vrcn/terms-of-service',
            ),
            isDarkMode: isDarkMode,
            t: t,
          ),

          Divider(color: Theme.of(context).colorScheme.outlineVariant),

          // プライバシーポリシー
          _buildCheckboxTile(
            title: t.termsAgreement.privacyTitle,
            subtitle: t.termsAgreement.privacySubtitle,
            value: _privacyAccepted,
            onChanged: (value) =>
                setState(() => _privacyAccepted = value ?? false),
            onLinkTap: () => externalLinkController.launch(
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
        AdaptiveCheckbox(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(!value),
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
                        foregroundColor: Theme.of(context).colorScheme.primary,
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
        ),
      ],
    );
  }

  Widget _buildNoticeSection(bool isDarkMode, Translations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            AppIcons.info_outline,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              t.termsAgreement.notice,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
          // iOS 26 のネイティブボタンは onPressed の null 変更だけでは再有効化されない。
          child: AdaptiveButton.child(
            onPressed: canProceed && !_isLoading ? _handleAccept : null,
            useNative: false,
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
            child: _isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                : Text(
                    t.common.agree,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: canProceed
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
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
