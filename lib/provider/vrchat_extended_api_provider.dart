import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart_generated/vrchat_dart_generated.dart';

final FutureProvider<AuthenticationApi> vrchatAuthenticationApiProvider =
    FutureProvider((ref) async {
      final rawApi = await ref.watch(vrchatRawApiProvider);
      return rawApi.getAuthenticationApi();
    });

final FutureProvider<CalendarApi> vrchatCalendarApiProvider = FutureProvider((
  ref,
) async {
  final rawApi = await ref.watch(vrchatRawApiProvider);
  return rawApi.getCalendarApi();
});

final FutureProvider<InventoryApi> vrchatInventoryApiProvider = FutureProvider((
  ref,
) async {
  final rawApi = await ref.watch(vrchatRawApiProvider);
  return rawApi.getInventoryApi();
});

final FutureProvider<NotificationsApi> vrchatNotificationsApiProvider =
    FutureProvider((ref) async {
      final rawApi = await ref.watch(vrchatRawApiProvider);
      return rawApi.getNotificationsApi();
    });

final FutureProvider<PrintsApi> vrchatPrintsApiProvider = FutureProvider((
  ref,
) async {
  final rawApi = await ref.watch(vrchatRawApiProvider);
  return rawApi.getPrintsApi();
});
