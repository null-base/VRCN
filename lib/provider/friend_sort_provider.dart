import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

/// フレンドの並び替え方法
enum FriendSortType {
  status, // オンライン状態順
  name, // 名前順
  lastLogin, // 最終ログイン順
}

/// 並び替えの方向
enum SortDirection {
  ascending, // 昇順
  descending, // 降順
}

/// 並び替え方法のプロバイダー
final friendSortTypeProvider =
    StateNotifierProvider<FriendSortTypeNotifier, FriendSortType>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      return FriendSortTypeNotifier(prefs);
    });

/// 並び替え方向のプロバイダー
final friendSortDirectionProvider =
    StateNotifierProvider<FriendSortDirectionNotifier, SortDirection>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      return FriendSortDirectionNotifier(prefs);
    });

/// 並び替え済みフレンドリストのプロバイダー
final sortedFriendsProvider = Provider<AsyncValue<List<LimitedUser>>>((ref) {
  final friendsAsync = ref.watch(friendsProvider);
  final sortType = ref.watch(friendSortTypeProvider);
  final sortDirection = ref.watch(friendSortDirectionProvider);

  return friendsAsync.whenData(
    (friends) => _sortFriends(friends, sortType, sortDirection),
  );
});

/// 並び替え方法の状態管理クラス
class FriendSortTypeNotifier extends StateNotifier<FriendSortType> {
  FriendSortTypeNotifier(this._prefs) : super(_getSavedSortType(_prefs));
  final SharedPreferences _prefs;
  static const _key = 'friend_sort_type';

  static FriendSortType _getSavedSortType(SharedPreferences prefs) {
    final index = prefs.getInt(_key) ?? 0;
    return FriendSortType.values[index < FriendSortType.values.length
        ? index
        : 0];
  }

  void setSortType(FriendSortType type) {
    _prefs.setInt(_key, type.index);
    state = type;
  }
}

/// 並び替え方向の状態管理クラス
class FriendSortDirectionNotifier extends StateNotifier<SortDirection> {
  FriendSortDirectionNotifier(this._prefs) : super(_getSavedDirection(_prefs));
  final SharedPreferences _prefs;
  static const _key = 'friend_sort_direction';

  static SortDirection _getSavedDirection(SharedPreferences prefs) {
    final index = prefs.getInt(_key) ?? 0;
    return SortDirection.values[index < SortDirection.values.length
        ? index
        : 0];
  }

  void setDirection(SortDirection direction) {
    _prefs.setInt(_key, direction.index);
    state = direction;
  }
}

/// オンライン状態の重み付け関数（ソート用）
int _getStatusWeight(UserStatus? status) {
  if (status == null) return 0;

  switch (status) {
    case UserStatus.joinMe:
      return 5;
    // case UserStatus.online:
    //   return 4;
    case UserStatus.active:
      return 3;
    case UserStatus.askMe:
      return 2;
    case UserStatus.busy:
      return 1;
    default:
      return 0;
  }
}

/// フレンドリストを並び替える関数
List<LimitedUser> _sortFriends(
  List<LimitedUser> friends,
  FriendSortType sortType,
  SortDirection direction,
) {
  final sortedList = List<LimitedUser>.from(friends);

  switch (sortType) {
    case FriendSortType.status:
      // オンライン状態でソート
      sortedList.sort((a, b) {
        final weightA = _getStatusWeight(a.status);
        final weightB = _getStatusWeight(b.status);
        final comparison = weightB.compareTo(weightA);
        return direction == SortDirection.ascending ? comparison : -comparison;
      });

    case FriendSortType.name:
      // 名前でソート
      sortedList.sort((a, b) {
        final comparison = a.displayName.compareTo(b.displayName);
        return direction == SortDirection.ascending ? comparison : -comparison;
      });

    case FriendSortType.lastLogin:
      // 最終ログイン順でソート
      sortedList.sort((a, b) {
        final lastLoginA =
            a.lastLogin ?? DateTime.fromMillisecondsSinceEpoch(0);
        final lastLoginB =
            b.lastLogin ?? DateTime.fromMillisecondsSinceEpoch(0);
        final comparison = lastLoginB.compareTo(lastLoginA);
        return direction == SortDirection.ascending ? comparison : -comparison;
      });
  }

  return sortedList;
}
