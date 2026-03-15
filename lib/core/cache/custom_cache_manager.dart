import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCacheManager {
  AppCacheManager._();

  static final BaseCacheManager instance = CacheManager(
    Config(
      'instagram_app_cache',
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 400,
      repo: JsonCacheInfoRepository(databaseName: 'instagram_app_cache'),
      fileService: HttpFileService(),
    ),
  );
}
