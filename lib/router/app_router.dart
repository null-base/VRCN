import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:vrchat/analytics_repository.dart';
import 'package:vrchat/pages/avatar_detail_page.dart';
import 'package:vrchat/pages/avatars_page.dart';
import 'package:vrchat/pages/credits_page.dart';
import 'package:vrchat/pages/engage_card_page.dart';
import 'package:vrchat/pages/event_calendar_page.dart';
import 'package:vrchat/pages/favorites_page.dart';
import 'package:vrchat/pages/friend_detail_page.dart';
import 'package:vrchat/pages/friends_page.dart';
import 'package:vrchat/pages/group_detail_page.dart';
import 'package:vrchat/pages/groups_page.dart';
import 'package:vrchat/pages/inventory_page.dart';
import 'package:vrchat/pages/login_page.dart';
import 'package:vrchat/pages/notifications_page.dart';
import 'package:vrchat/pages/osc_page.dart';
import 'package:vrchat/pages/profile_page.dart';
import 'package:vrchat/pages/qr_scanner_page.dart';
import 'package:vrchat/pages/search_page.dart';
import 'package:vrchat/pages/settings_page.dart';
import 'package:vrchat/pages/terms_agreement_page.dart';
import 'package:vrchat/pages/vrcnsync_page.dart';
import 'package:vrchat/pages/world_detail_page.dart';
import 'package:vrchat/provider/search_providers.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/router/navigation_observer.dart';
import 'package:vrchat/utils/first_launch_utils.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/navigation_bar.dart';

// スプラッシュ画面が表示されているかを追跡
final splashActiveProvider = StateProvider<bool>((ref) => true);

// 認証状態の変更を監視するためのStateProvider
final authRefreshProvider = StateProvider<int>((ref) => 0);

// 自動ログイン状態を追跡するプロバイダー
final autoLoginStateProvider = StateProvider<AutoLoginState>(
  (ref) => AutoLoginState.inProgress,
);

// 自動ログイン状態の列挙型
enum AutoLoginState {
  inProgress, // 自動ログイン処理中
  success, // 自動ログイン成功
  failed, // 自動ログイン失敗
}

// スプラッシュ画面を削除するプロバイダー（一定時間後に強制削除）
final removeSplashProvider = Provider<void>((ref) {
  // スプラッシュ画面を削除するタイマーを設定（最大5秒後）
  if (ref.read(splashActiveProvider)) {
    Future.delayed(const Duration(seconds: 5), () {
      // スプラッシュ画面をまだ削除していなければ削除
      if (ref.read(splashActiveProvider)) {
        FlutterNativeSplash.remove();
        ref.read(splashActiveProvider.notifier).state = false;
      }
    });
  }
});

// 認証状態を明示的に提供するプロバイダー
final authStateProvider = FutureProvider<bool>((ref) async {
  // スプラッシュ削除プロバイダーを監視
  ref.watch(removeSplashProvider);

  // 認証状態更新用トリガーを監視（ログイン/ログアウト時に変更）
  ref.watch(authRefreshProvider);

  try {
    final auth = await ref.watch(vrchatAuthProvider.future);
    return auth.currentUser != null;
  } catch (e) {
    return false;
  }
});

// 自動ログイン実行プロバイダー（結果を追跡状態にセットする）
final performAutoLoginProvider = FutureProvider<void>((ref) async {
  try {
    // 既に成功・失敗状態なら何もしない
    final currentState = ref.read(autoLoginStateProvider);
    if (currentState != AutoLoginState.inProgress) return;

    final autoLoginResult = await ref.watch(autoLoginProvider.future);

    // 結果に基づいて状態を更新
    if (autoLoginResult) {
      ref.read(autoLoginStateProvider.notifier).state = AutoLoginState.success;
    } else {
      ref.read(autoLoginStateProvider.notifier).state = AutoLoginState.failed;
    }

    // 自動ログイン処理が完了したら、スプラッシュ画面を確実に削除
    _removeSplashScreen(ref);
  } catch (e) {
    ref.read(autoLoginStateProvider.notifier).state = AutoLoginState.failed;
    // エラー時もスプラッシュ画面を削除
    _removeSplashScreen(ref);
  }
});

// スプラッシュ画面を削除するヘルパー関数
void _removeSplashScreen(Ref ref) async {
  // スプラッシュが表示されている場合
  if (ref.read(splashActiveProvider)) {
    // ユーザー情報を先に取得しておく（エラー時も続行）
    try {
      await ref.read(currentUserProvider.future);
    } catch (e) {
      debugPrint('初期ユーザー情報取得でエラー: $e');
      // エラーがあってもスプラッシュは消す
    }

    FlutterNativeSplash.remove();
    ref.read(splashActiveProvider.notifier).state = false;
  }
}

// スクリーン名をFirebase Analyticsに設定するヘルパーメソッド
void _setCurrentScreen(Ref ref, String screenName) {
  final analytics = ref.read(analyticsRepository);
  analytics.logScreenView(screenName: screenName);
}

final routerProvider = Provider<GoRouter>((ref) {
  final isInitializing = ref.watch(apiInitializingProvider);
  final authState = ref.watch(authStateProvider);
  final autoLoginState = ref.watch(autoLoginStateProvider);

  // 自動ログイン処理を開始（状態を監視）
  ref.watch(performAutoLoginProvider);

  final analyticsObserver = ref.read(analyticsObserverRepository);

  return GoRouter(
    refreshListenable: GoRouterRefreshStream(
      ref.read(authRefreshProvider.notifier).stream,
    ),
    initialLocation: '/',
    routerNeglect: true,
    observers: [
      VRChatNavigationObserver(ref.read(navigationIndexProvider.notifier)),
      analyticsObserver, // Firebase Analytics Observer
    ],
    redirect: (context, state) async {
      final location = state.uri.toString();
      final isLoginRoute = location == '/login';
      final isTermsRoute = location == '/terms';

      // API初期化中は何もしない
      if (isInitializing) {
        return null;
      }

      // 初回起動チェック
      final shouldShowOnboarding =
          await FirstLaunchUtils.shouldShowOnboarding();
      if (shouldShowOnboarding && !isTermsRoute) {
        return '/terms';
      }

      // 自動ログイン処理中は特別処理
      if (autoLoginState == AutoLoginState.inProgress) {
        // 一時的なロード画面を表示
        return location == '/loading' ? null : '/loading';
      }

      // 認証状態に基づいてリダイレクト
      return authState.when(
        data: (isLoggedIn) {
          // ログインしていない場合はログイン画面へ
          if (!isLoggedIn && !isLoginRoute && !isTermsRoute) {
            FlutterNativeSplash.remove();
            return '/login';
          }

          // ログイン済みでログイン画面にいる場合のみホーム画面へ
          if (isLoggedIn && isLoginRoute) {
            FlutterNativeSplash.remove();
            return '/';
          }

          return null;
        },
        loading: () => null,
        error: (_, _) => isLoginRoute || isTermsRoute ? null : '/login',
      );
    },
    routes: [
      // 利用規約同意画面を追加
      GoRoute(
        path: '/terms',
        name: 'terms',
        builder: (context, state) {
          _setCurrentScreen(ref, '利用規約同意画面');
          return const TermsAgreementPage();
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          final location = state.uri.toString();
          var currentIndex = 0;

          if (location == '/search') {
            currentIndex = 1;
          } else if (location == '/notifications') {
            currentIndex = 2;
          }

          return Navigation(currentIndex: currentIndex, child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) {
              final immediate =
                  (state.extra as Map<String, dynamic>?)?['immediate'] == true;
              // スクリーン名を設定
              _setCurrentScreen(ref, 'ホーム画面');
              if (immediate) {
                return const NoTransitionPage(child: FriendsPage());
              }
              return const MaterialPage(child: FriendsPage());
            },
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            pageBuilder: (context, state) {
              _setCurrentScreen(ref, '検索画面');
              return MaterialPage(
                child: SearchPage(key: ref.read(searchPageKeyProvider)),
              );
            },
          ),
          // GoRoute(
          //   path: '/notifications',
          //   name: 'notifications',
          //   pageBuilder: (context, state) {
          //     _setCurrentScreen(ref, '通知画面');
          //     final immediate =
          //         (state.extra as Map<String, dynamic>?)?['immediate'] == true;
          //     if (immediate) {
          //       return const NoTransitionPage(child: NotificationsPage());
          //     }
          //     return const MaterialPage(child: NotificationsPage());
          //   },
          // ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          _setCurrentScreen(ref, 'ログイン画面');
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) {
          _setCurrentScreen(ref, '通知画面');
          return const NotificationsPage();
        },
      ),
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (context, state) {
          _setCurrentScreen(ref, '読み込み中');
          return const LoadingIndicator();
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) {
          _setCurrentScreen(ref, '設定画面');
          return const SettingsPage();
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) {
          _setCurrentScreen(ref, 'プロフィール画面');
          return const ProfilePage();
        },
      ),
      GoRoute(
        path: '/user/:id',
        name: 'user_details',
        builder: (context, state) {
          final userId = state.pathParameters['id']!;
          _setCurrentScreen(ref, 'ユーザー詳細画面:$userId');
          return FriendDetailPage(userId: userId);
        },
      ),
      GoRoute(
        path: '/avatar/:avatarId',
        name: 'avatar_details',
        builder: (context, state) {
          final avatarId = state.pathParameters['avatarId']!;
          _setCurrentScreen(ref, 'アバター詳細画面:$avatarId');
          return AvatarDetailPage(avatarId: avatarId);
        },
      ),
      GoRoute(
        path: '/world/:worldId',
        name: 'world_details',
        builder: (context, state) {
          final worldId = state.pathParameters['worldId']!;
          _setCurrentScreen(ref, 'ワールド詳細画面:$worldId');
          return WorldDetailPage(worldId: worldId);
        },
      ),
      GoRoute(
        path: '/group/:groupId',
        name: 'group_details',
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          _setCurrentScreen(ref, 'グループ詳細画面:$groupId');
          return GroupDetailPage(groupId: groupId);
        },
      ),
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) {
          _setCurrentScreen(ref, 'お気に入り画面');
          return const FavoritesPage();
        },
      ),
      // GoRoute(
      //   path: '/notifications',
      //   name: 'notifications',
      //   pageBuilder: (context, state) {
      //     _setCurrentScreen(ref, '通知画面');
      //     final immediate =
      //         (state.extra as Map<String, dynamic>?)?['immediate'] == true;
      //     if (immediate) {
      //       return const NoTransitionPage(child: NotificationsPage());
      //     }
      //     return const MaterialPage(child: NotificationsPage());
      //   },
      // ),
      GoRoute(
        path: '/groups',
        name: 'groups',
        builder: (context, state) {
          _setCurrentScreen(ref, 'グループ一覧画面');
          return const GroupsPage();
        },
      ),
      GoRoute(
        path: '/avatars',
        name: 'avatars',
        builder: (context, state) {
          _setCurrentScreen(ref, 'アバター一覧画面');
          return const AvatarsPage();
        },
      ),
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        builder: (context, state) {
          _setCurrentScreen(ref, 'インベントリ画面');
          return const InventoryPage();
        },
      ),
      GoRoute(
        path: '/event_calendar',
        name: 'event_calendar',
        builder: (context, state) {
          _setCurrentScreen(ref, 'イベントカレンダー');
          return const EventCalendarPage();
        },
      ),
      GoRoute(
        path: '/osc',
        name: 'osc',
        builder: (context, state) {
          _setCurrentScreen(ref, 'OSCコントローラー');
          return const OscPage();
        },
      ),
      GoRoute(
        path: '/vrcnsync',
        name: 'vrcnsync',
        builder: (context, state) {
          _setCurrentScreen(ref, 'VRCNSync');
          return const VrcnSyncPage();
        },
      ),
      GoRoute(
        path: '/credits',
        name: 'credits',
        builder: (context, state) {
          _setCurrentScreen(ref, 'クレジット画面');
          return const CreditsPage();
        },
      ),
      GoRoute(
        path: '/engage_card',
        name: 'engage_card',
        builder: (context, state) {
          _setCurrentScreen(ref, 'オフ会用画面');
          return const EngageCardPage();
        },
      ),
      GoRoute(
        path: '/qr_scanner',
        name: 'qr_scanner',
        builder: (context, state) {
          _setCurrentScreen(ref, 'QRスキャナー画面');
          return const QrScannerPage();
        },
      ),
    ],
  );
});

// NoTransitionPageクラス - アニメーションなしの遷移ページ
class NoTransitionPage<T> extends Page<T> {
  final Widget child;

  const NoTransitionPage({required this.child, super.key});

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (_, _, _) => child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}

// GoRouterのリフレッシュを行うためのヘルパークラス
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
