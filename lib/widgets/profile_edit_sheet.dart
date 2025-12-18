import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/status_helpers.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class ProfileEditSheet extends ConsumerStatefulWidget {
  final CurrentUser user;

  const ProfileEditSheet({super.key, required this.user});

  @override
  ConsumerState<ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends ConsumerState<ProfileEditSheet>
    with SingleTickerProviderStateMixin {
  late TextEditingController _statusDescriptionController;
  late TextEditingController _bioController;
  List<TextEditingController> _bioLinkControllers = [];
  late TextEditingController _pronounsController;
  late UserStatus _selectedStatus;
  var _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // フォーカスノード
  final _bioFocusNode = FocusNode();
  final _statusDescriptionFocusNode = FocusNode();
  final _pronounsFocusNode = FocusNode();

  // 現在選択されているカテゴリ
  var _selectedCategoryIndex = 0;

  // カテゴリ定義
  final List<Map<String, dynamic>> _categories = [
    {'title': t.profile.status, 'icon': Icons.mood, 'color': Colors.green},
    {
      'title': t.profile.bio,
      'icon': Icons.person_outline,
      'color': Colors.blue,
    },
    {'title': t.profile.links, 'icon': Icons.link, 'color': Colors.purple},
    {
      'title': t.profile.basic,
      'icon': Icons.info_outline,
      'color': Colors.orange,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();

    // アニメーションコントローラの初期化
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _initializeControllers() {
    _statusDescriptionController = TextEditingController(
      text: widget.user.statusDescription,
    );
    _bioController = TextEditingController(text: widget.user.bio);
    _bioLinkControllers =
        widget.user.bioLinks
            .map((link) => TextEditingController(text: link))
            .toList();
    if (_bioLinkControllers.isEmpty) {
      _bioLinkControllers.add(TextEditingController());
    }
    _pronounsController = TextEditingController(text: widget.user.pronouns);
    _selectedStatus = widget.user.status;
  }

  @override
  void dispose() {
    _statusDescriptionController.dispose();
    _bioController.dispose();
    for (final controller in _bioLinkControllers) {
      controller.dispose();
    }
    _pronounsController.dispose();
    _bioFocusNode.dispose();
    _statusDescriptionFocusNode.dispose();
    _pronounsFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final bioLinks =
          _bioLinkControllers
              .map((controller) => controller.text.trim())
              .where((link) => link.isNotEmpty)
              .toList();

      final updateRequest = UpdateUserRequest(
        status: _selectedStatus,
        statusDescription: _statusDescriptionController.text,
        bio: _bioController.text,
        bioLinks: bioLinks,
        pronouns: _pronounsController.text,
      );

      await ref.read(updateUserProvider(updateRequest).future);

      // プロバイダーを無効化して最新データを取得
      ref.invalidate(currentUserProvider); // これを追加

      // 最新のユーザー情報を確実に取得
      try {
        await ref.read(currentUserProvider.future);
      } catch (e) {
        debugPrint('ユーザー情報の再取得中にエラーが発生: $e');
        // エラーが発生しても保存成功として処理を続行
      }

      if (mounted) {
        // 保存成功アニメーション
        setState(() {
          _isLoading = false;
        });

        // 成功メッセージ表示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(t.profile.saved),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );

        // 閉じるアニメーション
        await _animationController.reverse();
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    t.profile.saveFailed.replaceFirst('{error}', e.toString()),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    const accentColor = AppTheme.primaryColor;
    final secondaryColor =
        isDarkMode
            ? HSLColor.fromColor(accentColor).withLightness(0.4).toColor()
            : HSLColor.fromColor(accentColor).withLightness(0.6).toColor();
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return WillPopScope(
      onWillPop: () async {
        if (_hasUnsavedChanges()) {
          final shouldDiscard = await _showDiscardChangesDialog();
          return shouldDiscard;
        }
        return true;
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return FractionallySizedBox(
            heightFactor: 0.85 * _animation.value,
            child: child,
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // 装飾的な背景エレメント
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor.withValues(alpha: 0.05),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -60,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor.withValues(alpha: 0.07),
                  ),
                ),
              ),

              // メインコンテンツ
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ヘッダー
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Column(
                      children: [
                        // ハンドル
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ヘッダー
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: accentColor),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                t.profile.edit,
                                style: GoogleFonts.notoSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // カテゴリ選択
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategoryIndex == index;
                        final categoryColor = category['color'] as Color;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? categoryColor.withValues(
                                        alpha: isDarkMode ? 0.2 : 0.1,
                                      )
                                      : isDarkMode
                                      ? Colors.grey[850]
                                      : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? categoryColor
                                        : isDarkMode
                                        ? Colors.grey[700]!
                                        : Colors.grey[300]!,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  category['icon'] as IconData,
                                  size: 20,
                                  color:
                                      isSelected
                                          ? categoryColor
                                          : isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  category['title'] as String,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected
                                            ? categoryColor
                                            : isDarkMode
                                            ? Colors.grey[300]
                                            : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // コンテンツエリア
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: _buildCategoryContent(
                        isDarkMode,
                        accentColor,
                        secondaryColor,
                      ),
                    ),
                  ),

                  // 保存ボタン
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: accentColor.withValues(alpha: 0.4),
                        ),
                        child:
                            _isLoading
                                ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check_circle),
                                    const SizedBox(width: 10),
                                    Text(
                                      t.profile.save,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 選択されたカテゴリに応じたコンテンツを表示
  Widget _buildCategoryContent(
    bool isDarkMode,
    Color accentColor,
    Color secondaryColor,
  ) {
    switch (_selectedCategoryIndex) {
      case 0: // ステータス
        return _buildStatusCategory(isDarkMode, accentColor);
      case 1: // 自己紹介
        return _buildBioCategory(isDarkMode, accentColor);
      case 2: // リンク
        return _buildLinksCategory(isDarkMode, accentColor, secondaryColor);
      case 3: // 基本情報
        return _buildBasicInfoCategory(isDarkMode, accentColor);
      default:
        return const SizedBox.shrink();
    }
  }

  // ステータスカテゴリ
  Widget _buildStatusCategory(bool isDarkMode, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          t.profile.status,
          Icons.mood,
          Colors.green,
          isDarkMode,
        ),
        const SizedBox(height: 16),
        _buildStatusSelector(isDarkMode, Colors.green),
        const SizedBox(height: 24),

        _buildSectionHeader(
          t.profile.statusMessage,
          Icons.chat_bubble_outline,
          Colors.green,
          isDarkMode,
        ),
        const SizedBox(height: 12),
        _buildStyledTextField(
          controller: _statusDescriptionController,
          focusNode: _statusDescriptionFocusNode,
          hintText: t.profile.statusMessageHint,
          maxLength: 100,
          prefix: Icon(
            Icons.short_text,
            color: Colors.green.withValues(alpha: 0.7),
            size: 22,
          ),
          isDarkMode: isDarkMode,
          accentColor: Colors.green,
        ),
      ],
    );
  }

  // 自己紹介カテゴリ
  Widget _buildBioCategory(bool isDarkMode, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          t.profile.bio,
          Icons.person_outline,
          Colors.blue,
          isDarkMode,
        ),
        const SizedBox(height: 12),
        _buildStyledTextField(
          controller: _bioController,
          focusNode: _bioFocusNode,
          hintText: t.profile.bioHint,
          maxLength: 500,
          maxLines: 8,
          isDarkMode: isDarkMode,
          accentColor: Colors.blue,
        ),
      ],
    );
  }

  // リンクカテゴリ
  Widget _buildLinksCategory(
    bool isDarkMode,
    Color accentColor,
    Color secondaryColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader(
              t.profile.links,
              Icons.link,
              Colors.purple,
              isDarkMode,
            ),
            TextButton.icon(
              onPressed: _addLinkField,
              icon: const Icon(Icons.add, size: 18),
              label: Text(t.profile.addLink),
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
                backgroundColor: Colors.purple.withValues(alpha: 0.1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._bioLinkControllers.asMap().entries.map(
          (entry) => _buildLinkField(
            entry.key,
            isDarkMode,
            Colors.purple,
            secondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.profile.linksHint,
          style: GoogleFonts.notoSans(
            fontSize: 12,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // 基本情報カテゴリ
  Widget _buildBasicInfoCategory(bool isDarkMode, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          t.profile.pronouns,
          Icons.label_outline,
          Colors.orange,
          isDarkMode,
        ),
        const SizedBox(height: 12),
        _buildStyledTextField(
          controller: _pronounsController,
          focusNode: _pronounsFocusNode,
          hintText: 'he/him, she/her, they/them',
          maxLength: 50,
          prefix: Icon(
            Icons.person_pin,
            color: Colors.orange.withValues(alpha: 0.7),
            size: 22,
          ),
          isDarkMode: isDarkMode,
          accentColor: Colors.orange,
        ),
        const SizedBox(height: 20),

        // 現在のユーザー情報表示
        _buildInfoItem(
          t.profile.username,
          widget.user.username.toString(),
          Icons.account_circle,
          Colors.orange,
          isDarkMode,
        ),
        const SizedBox(height: 12),
        _buildInfoItem(
          t.profile.displayName,
          widget.user.displayName,
          Icons.badge,
          Colors.orange,
          isDarkMode,
        ),
        const SizedBox(height: 12),
        _buildInfoItem(
          t.profile.dateJoined,
          _formatDate(widget.user.dateJoined),
          Icons.calendar_today,
          Colors.orange,
          isDarkMode,
        ),
      ],
    );
  }

  // 読み取り専用の情報アイテム
  Widget _buildInfoItem(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDarkMode ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.notoSans(
                    fontSize: 13,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 日付フォーマット
  String _formatDate(DateTime? date) {
    if (date == null || date == DateTime.fromMillisecondsSinceEpoch(0)) {
      return '不明';
    }
    return '${date.year}年${date.month}月${date.day}日';
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    Color accentColor,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: accentColor),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    int maxLength = 100,
    int maxLines = 1,
    Widget? prefix,
    required bool isDarkMode,
    required Color accentColor,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        maxLines: maxLines,
        keyboardType:
            maxLines > 1 ? TextInputType.multiline : TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        style: GoogleFonts.notoSans(
          color: isDarkMode ? Colors.white : Colors.black87,
          height: 1.5,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.notoSans(
            color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
          ),
          prefixIcon: prefix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          counterStyle: GoogleFonts.notoSans(
            color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            fontSize: 12,
          ),
        ),
        cursorColor: accentColor,
      ),
    );
  }

  Widget _buildStatusSelector(bool isDarkMode, Color accentColor) {
    final statusList = [
      UserStatus.active,
      UserStatus.joinMe,
      UserStatus.askMe,
      UserStatus.busy,
      UserStatus.offline,
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<UserStatus>(
            value: _selectedStatus,
            isExpanded: true,
            dropdownColor: isDarkMode ? Colors.grey[850] : Colors.white,
            borderRadius: BorderRadius.circular(16),
            items:
                statusList.map((status) {
                  final statusText = StatusHelper.getStatusText(status);
                  final statusColor = StatusHelper.getStatusColor(status);

                  return DropdownMenuItem<UserStatus>(
                    value: status,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: statusColor.withValues(alpha: 0.4),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          statusText,
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedStatus = newValue;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLinkField(
    int index,
    bool isDarkMode,
    Color accentColor,
    Color secondaryColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(
              Icons.link,
              size: 20,
              color: accentColor.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _bioLinkControllers[index],
                decoration: InputDecoration(
                  hintText: t.profile.linkHint,
                  hintStyle: GoogleFonts.notoSans(
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                ),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                cursorColor: accentColor,
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red[400], size: 22),
              onPressed: () => _removeLinkField(index),
              tooltip: t.common.delete,
              style: IconButton.styleFrom(
                backgroundColor: Colors.red[50]?.withValues(alpha: 0.2),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  void _addLinkField() {
    setState(() {
      _bioLinkControllers.add(TextEditingController());
    });
  }

  void _removeLinkField(int index) {
    setState(() {
      _bioLinkControllers[index].dispose();
      _bioLinkControllers.removeAt(index);

      if (_bioLinkControllers.isEmpty) {
        _bioLinkControllers.add(TextEditingController());
      }
    });
  }

  // 変更があるかチェックする関数
  bool _hasUnsavedChanges() {
    // オリジナルの値と現在の値を比較
    if (_statusDescriptionController.text != widget.user.statusDescription) {
      return true;
    }
    if (_bioController.text != widget.user.bio) {
      return true;
    }
    if (_pronounsController.text != widget.user.pronouns) {
      return true;
    }
    if (_selectedStatus != widget.user.status) {
      return true;
    }

    // リンク数が変わっていれば変更あり
    if (_bioLinkControllers.length != widget.user.bioLinks.length) {
      return true;
    }

    // リンクの中身を比較
    for (var i = 0; i < _bioLinkControllers.length; i++) {
      if (i >= widget.user.bioLinks.length ||
          _bioLinkControllers[i].text.trim() != widget.user.bioLinks[i]) {
        return true;
      }
    }

    return false; // 変更なし
  }

  // 確認ダイアログを表示する関数
  Future<bool> _showDiscardChangesDialog() async {
    if (!mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (dialogContext) => AlertDialog(
            // contextではなくdialogContextを使用
            title: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.amber[700]),
                const SizedBox(width: 12),
                Text(t.profile.discardTitle),
              ],
            ),
            content: Text(t.profile.discardContent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor:
                Theme.of(dialogContext).brightness ==
                        Brightness
                            .dark // dialogContextを使用
                    ? Colors.grey[850]
                    : Colors.white,
            elevation: 8,
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.of(
                      dialogContext,
                    ).pop(false), // dialogContextを使用
                child: Text(
                  t.profile.discardCancel,
                  style: const TextStyle(color: AppTheme.primaryColor),
                ),
              ),
              ElevatedButton(
                onPressed:
                    () => Navigator.of(
                      dialogContext,
                    ).pop(true), // dialogContextを使用
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(t.profile.discardOk),
              ),
            ],
          ),
    );

    return result ?? false;
  }
}
