import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/instance_helper.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class WorldInstanceView extends StatelessWidget {
  final AsyncValue<World>? worldDetailAsync;
  final AsyncValue<Instance>? instanceDetailAsync;
  final bool isDarkMode;
  final Map<String, String> headers;

  const WorldInstanceView({
    super.key,
    required this.worldDetailAsync,
    required this.instanceDetailAsync,
    required this.isDarkMode,
    required this.headers,
  });

  @override
  Widget build(BuildContext context) {
    // インスタンス情報がある場合
    if (instanceDetailAsync != null) {
      return instanceDetailAsync!.when(
        data:
            (instanceInfo) =>
                _buildInstanceContent(context, worldDetailAsync, instanceInfo),
        loading: _buildLoadingView,
        error: (error, _) => _buildErrorView(error.toString()),
      );
    }
    // ワールド情報のみある場合
    else if (worldDetailAsync != null) {
      return worldDetailAsync!.when(
        data: (worldInfo) => _buildWorldImageView(context, worldInfo, null),
        loading: _buildLoadingView,
        error: (error, _) => _buildErrorView(error.toString()),
      );
    }
    // どちらも情報がない場合
    else {
      return _buildNoInfoView();
    }
  }

  Widget _buildInstanceContent(
    BuildContext context,
    AsyncValue<World>? worldDetailAsync,
    Instance instanceInfo,
  ) {
    if (worldDetailAsync == null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isDarkMode
                  ? Colors.black.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  InstanceHelper.getInstanceTypeIcon(
                    instanceInfo.type.toString(),
                  ),
                  size: 18,
                  color: isDarkMode ? Colors.green[200] : Colors.green[700],
                ),
                const SizedBox(width: 8),
                Text(
                  t.location.instanceType(
                    type: InstanceHelper.getInstanceTypeText(
                      instanceInfo.type.toString(),
                    ),
                  ),
                  style: GoogleFonts.notoSans(
                    fontSize: 15,
                    color: isDarkMode ? Colors.green[100] : Colors.green[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 18,
                  color: isDarkMode ? Colors.green[200] : Colors.green[700],
                ),
                const SizedBox(width: 8),
                Text(
                  t.location.playerCount(
                    userCount: instanceInfo.userCount.toString(),
                    capacity: instanceInfo.capacity.toString(),
                  ),
                  style: GoogleFonts.notoSans(
                    fontSize: 15,
                    color: isDarkMode ? Colors.green[100] : Colors.green[800],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return worldDetailAsync.when(
      data:
          (worldInfo) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (worldInfo.imageUrl.isNotEmpty)
                _buildWorldImageView(context, worldInfo, instanceInfo),
            ],
          ),
      loading:
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildLoadingView()],
          ),
      error:
          (_, _) => Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? Colors.black.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      InstanceHelper.getInstanceTypeIcon(
                        instanceInfo.type.toString(),
                      ),
                      size: 18,
                      color: isDarkMode ? Colors.green[200] : Colors.green[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.location.instanceType(
                        type: InstanceHelper.getInstanceTypeText(
                          instanceInfo.type.toString(),
                        ),
                      ),
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        color:
                            isDarkMode ? Colors.green[100] : Colors.green[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 18,
                      color: isDarkMode ? Colors.green[200] : Colors.green[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.location.playerCount(
                        userCount: instanceInfo.userCount.toString(),
                        capacity: instanceInfo.capacity.toString(),
                      ),
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        color:
                            isDarkMode ? Colors.green[100] : Colors.green[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildWorldImageView(
    BuildContext context,
    World worldInfo,
    Instance? instanceInfo,
  ) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 8),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ワールド画像
              CachedNetworkImage(
                imageUrl: worldInfo.imageUrl,
                fit: BoxFit.cover,
                httpHeaders: headers,
                cacheManager: JsonCacheManager(),
                placeholder:
                    (context, url) => Container(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                        ),
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
              ),

              // グラデーションオーバーレイ
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.6),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),

              // ワールド名とプレイヤー情報
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.push('/world/${worldInfo.id}'),
                      child: Text(
                        instanceInfo != null
                            ? '${worldInfo.name}#${instanceInfo.name}'
                            : worldInfo.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.8),
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // プレイヤー数表示（インスタンス情報がある場合のみ）
                    if (instanceInfo != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 16,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${instanceInfo.userCount} / ${instanceInfo.capacity}',
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.9),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.8),
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // インスタンスタイプバッジ（インスタンス情報がある場合のみ）
              if (instanceInfo != null)
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: InstanceHelper.getInstanceTypeColor(
                        instanceInfo.type.toString(),
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      InstanceHelper.getInstanceTypeText(
                        instanceInfo.type.toString(),
                      ),
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }

  Widget _buildErrorView(String errorMessage) {
    // プライベートロケーションのエラーを検出
    final isPrivateLocation =
        errorMessage.toLowerCase().contains('private') ||
        errorMessage.toLowerCase().contains('permission') ||
        errorMessage.toLowerCase().contains('401') ||
        errorMessage.toLowerCase().contains('403');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isPrivateLocation
                ? (isDarkMode
                    ? Colors.blue.shade900.withValues(alpha: 0.2)
                    : Colors.blue.shade50)
                : (isDarkMode
                    ? Colors.red.shade900.withValues(alpha: 0.2)
                    : Colors.red.shade50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isPrivateLocation
                  ? Colors.blue.withValues(alpha: 0.3)
                  : Colors.red.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isPrivateLocation ? Icons.lock_outline : Icons.error_outline,
                color: isPrivateLocation ? Colors.blue[300] : Colors.red[300],
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isPrivateLocation
                      ? t.location.privateLocation
                      : t.location.fetchError,
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        isPrivateLocation ? Colors.blue[300] : Colors.red[300],
                  ),
                ),
              ),
            ],
          ),
          if (!isPrivateLocation && errorMessage.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              t.common.error(error: errorMessage),
              style: GoogleFonts.notoSans(fontSize: 12, color: Colors.red[200]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoInfoView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Text(
        t.location.noInfo,
        style: GoogleFonts.notoSans(
          fontSize: 16,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
