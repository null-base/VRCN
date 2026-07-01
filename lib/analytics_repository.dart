import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/utils/app_logger.dart';

/// FirebaseAnalyticsのインスタンス
final Provider<AnalyticsService> analyticsRepository = Provider(
  (ref) => AnalyticsService(),
);

/// FirebaseAnalyticsObserverのインスタンス
final Provider<FirebaseAnalyticsObserver> analyticsObserverRepository =
    Provider(
      (ref) => FirebaseAnalyticsObserver(
        analytics: FirebaseAnalytics.instance,
        nameExtractor: (settings) {
          return settings.name;
        },
      ),
    );

/// Analyticsサービスクラス
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // 画面表示のログ記録
  void logScreenView({required String screenName}) {
    appLogger.d('Screen view: $screenName');
    _analytics.logScreenView(screenName: screenName);
  }

  // アプリ開始ログ
  void logAppOpen() {
    _analytics.logAppOpen();
  }

  // カスタムイベント記録
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }
}
