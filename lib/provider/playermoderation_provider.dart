import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final FutureProvider<PlayermoderationApi> vrchatPlayermoderationProvider =
    FutureProvider((ref) async {
      final rawApi = await ref.watch(vrchatRawApiProvider);
      return rawApi.getPlayermoderationApi();
    });

// ユーザーをモデレートするためのプロバイダー
final FutureProviderFamily<PlayerModeration, ModerateUserRequest>
moderateUserProvider =
    FutureProvider.family<PlayerModeration, ModerateUserRequest>((
      ref,
      request,
    ) async {
      final api = await ref.watch(vrchatPlayermoderationProvider.future);

      try {
        final result = await api.moderateUser(moderateUserRequest: request);
        if (result.data == null) {
          throw Exception('ユーザーのモデレート結果がnullでした');
        }
        return result.data!;
      } catch (e) {
        throw Exception('ユーザーのモデレートに失敗しました: $e');
      }
    });

// ユーティリティクラス - よく使う操作を簡単に行うためのヘルパー
class PlayerModerationUtil {
  // ユーザーをブロックする
  static ModerateUserRequest blockUser(String userId) {
    return ModerateUserRequest(
      moderated: userId,
      type: PlayerModerationType.block,
    );
  }

  // ユーザーをミュートする
  static ModerateUserRequest muteUser(String userId) {
    return ModerateUserRequest(
      moderated: userId,
      type: PlayerModerationType.mute,
    );
  }
}
