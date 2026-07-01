import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class JsonCacheManager extends CacheManager with ImageCacheManager {
  factory JsonCacheManager() {
    return _instance;
  }

  JsonCacheManager._() : super(Config(key, repo: JsonCacheInfoRepository()));
  static const key = 'libCachedImageData';

  static final _instance = JsonCacheManager._();
}
