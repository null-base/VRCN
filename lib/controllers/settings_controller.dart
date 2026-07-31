import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/auth_refresh_provider.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';
import 'package:vrchat/provider/cache_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/gen/strings.g.dart';

class SettingsController {
  const SettingsController(this.ref);

  final Ref ref;

  Future<void> logout() async {
    await ref.read(authStorageProvider).clearCredentials();
    final auth = await ref.read(vrchatAuthProvider.future);
    await auth.logout();
    ref.read(authRefreshProvider.notifier).state++;
  }

  Future<bool> clearCache() async {
    final success = await ref.read(cacheServiceProvider).clearCache();
    ref.invalidate(cacheSizeProvider);
    return success;
  }

  Future<void> setAllowNsfw(bool value) {
    return ref.read(settingsProvider.notifier).setAllowNsfw(value);
  }

  Future<void> setEnableEventReminders(bool value) {
    return ref.read(settingsProvider.notifier).setEnableEventReminders(value);
  }

  Future<void> setThemeMode(AppThemeMode mode) {
    return ref.read(settingsProvider.notifier).setThemeMode(mode);
  }

  Future<void> setAvatarSearchApiUrl(String url) {
    return ref.read(settingsProvider.notifier).setAvatarSearchApiUrl(url);
  }

  Future<void> setLocale(AppLocale locale) {
    return ref.read(settingsProvider.notifier).setLocale(locale);
  }

  Future<bool> setAppIcon(AppIconType iconType) {
    return ref.read(settingsProvider.notifier).setAppIcon(iconType);
  }

  Future<bool> isAppIconChangeSupported() {
    return ref.read(settingsProvider.notifier).isAppIconChangeSupported();
  }
}

final settingsControllerProvider = Provider<SettingsController>((ref) {
  return SettingsController(ref);
});
