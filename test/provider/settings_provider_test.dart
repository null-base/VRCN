import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/settings_provider.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocaleSettings.setLocale(AppLocale.en);
  });

  test(
    'persists and restores Traditional Chinese without falling back',
    () async {
      SharedPreferences.setMockInitialValues({
        'locale': 'zhTw',
        'localeOverride': true,
      });
      await LocaleSettings.setLocale(AppLocale.zhTw);

      final prefs = await SharedPreferences.getInstance();
      final notifier = SettingsNotifier(prefs);

      expect(notifier.state.locale, AppLocale.zhTw);

      await notifier.setLocale(AppLocale.zhTw);

      expect(prefs.getString('locale'), 'zhTw');
      expect(prefs.getBool('localeOverride'), isTrue);
      expect(notifier.state.locale, AppLocale.zhTw);

      notifier.dispose();
    },
  );
}
