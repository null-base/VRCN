import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:vrchat/controllers/engage_card_controller.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/engage_card_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart' hide File;

class EngageCardPage extends ConsumerStatefulWidget {
  const EngageCardPage({super.key});

  @override
  ConsumerState<EngageCardPage> createState() => _EngageCardPageState();
}

class _EngageCardPageState extends ConsumerState<EngageCardPage> {
  double? _oldBrightness;
  var _showAppBar = true;
  Timer? _hideAppBarTimer;
  var _showAvatar = true; // アバター表示/非表示フラグ

  @override
  void initState() {
    super.initState();
    _loadBackgroundImage();
    _setMaxBrightness();
    _startHideAppBarTimer();

    // ステータスバー等を非表示
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void _startHideAppBarTimer() {
    _hideAppBarTimer?.cancel();
    _showAppBar = true;
    setState(() {});
    _hideAppBarTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showAppBar = false;
      });
    });
  }

  @override
  void dispose() {
    _hideAppBarTimer?.cancel();
    if (_oldBrightness != null) {
      ScreenBrightness().setApplicationScreenBrightness(_oldBrightness!);
    }
    // ページ離脱時にUIモードを元に戻す
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<void> _setMaxBrightness() async {
    try {
      _oldBrightness = await ScreenBrightness.instance.system;
      await ScreenBrightness().setApplicationScreenBrightness(1);
    } catch (_) {}
  }

  Future<void> _loadBackgroundImage() async {
    await ref.read(engageCardControllerProvider).loadBackgroundImage();
  }

  Future<void> _pickImage() async {
    await ref.read(engageCardControllerProvider).pickBackgroundImage();
  }

  // 背景画像削除
  Future<void> _removeBackgroundImage() async {
    await ref.read(engageCardControllerProvider).removeBackgroundImage();
  }

  // タップや操作時にAppBarを再表示
  void _onUserInteraction() {
    if (!_showAppBar) {
      setState(() {
        _showAppBar = true;
      });
    }
    _startHideAppBarTimer();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final backgroundImage = ref.watch(backgroundImageProvider);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onUserInteraction,
      onPanDown: (_) => _onUserInteraction(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _showAppBar
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.photo_library_outlined),
                    onPressed: _pickImage,
                    tooltip: t.engageCard.pickBackground,
                  ),
                  if (backgroundImage != null)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      onPressed: _removeBackgroundImage,
                      tooltip: t.engageCard.removeBackground,
                    ),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: () => context.push('/qr_scanner'),
                    tooltip: t.engageCard.scanQr,
                  ),
                  IconButton(
                    icon: Icon(
                      _showAvatar ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    tooltip: _showAvatar
                        ? t.engageCard.hideAvatar
                        : t.engageCard.showAvatar,
                    onPressed: () {
                      setState(() {
                        _showAvatar = !_showAvatar;
                      });
                    },
                  ),
                ],
              )
            : null,
        body: currentUserAsync.when(
          data: (user) {
            return Stack(
              children: [
                // 背景
                if (backgroundImage != null)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(backgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  // 背景画像が未選択時のメッセージ
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF23243B), Color(0xFF3B8D99)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      t.engageCard.noBackground,
                      style: GoogleFonts.notoSans(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                // カード本体（画面下部に寄せる）
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildEngageCardFront(user, headers),
                  ),
                ),
              ],
            );
          },
          loading: () => const LoadingIndicator(),
          error: (err, stack) => Center(
            child: Text(
              t.engageCard.error(error: err.toString()),
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEngageCardFront(CurrentUser user, Map<String, String> headers) {
    return Container(
      width: 370,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 36,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.24),
                    ),
                  ),
                ),
              ),
              // グラデーションオーバーレイ
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.tealAccent.withValues(alpha: 0.08),
                        Colors.blue.withValues(alpha: 0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: _showAvatar
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_showAvatar)
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: user.userIcon.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  user.userIcon,
                                  headers: headers,
                                  cacheManager: JsonCacheManager(),
                                )
                              : user.currentAvatarThumbnailImageUrl.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  user.currentAvatarThumbnailImageUrl,
                                  headers: headers,
                                  cacheManager: JsonCacheManager(),
                                )
                              : AssetImage(Assets.icons.icon.path)
                                    as ImageProvider,
                          backgroundColor: Colors.white24,
                        ),
                      if (_showAvatar) const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: _showAvatar
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FittedBox(
                              child: Text(
                                user.displayName,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QrImageView(
                        data: 'https://vrchat.com/home/user/${user.id}',
                        // QRコードの色
                        // ignore: deprecated_member_use
                        foregroundColor: Colors.white,
                        size: 90,
                        embeddedImage: AssetImage(Assets.images.logo.path),
                        embeddedImageStyle: const QrEmbeddedImageStyle(
                          size: Size(20, 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
