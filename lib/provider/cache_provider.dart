import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/services/cache_service.dart';

// キャッシュサービスのプロバイダー
final cacheServiceProvider = Provider<CacheService>((ref) {
  return CacheService();
});

// キャッシュサイズのプロバイダー
final cacheSizeProvider = FutureProvider<String>((ref) {
  final cacheService = ref.watch(cacheServiceProvider);
  return cacheService.getCacheSize();
});
