import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vrchat/main.dart' as app;
import 'package:vrchat/pages/login_page.dart';
import 'package:vrchat/pages/terms_agreement_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('accessible app routes render without framework errors', (
    tester,
  ) async {
    await app.main();
    await _pumpUntilFirstPage(tester);

    final scaffold = find.byType(Scaffold);
    expect(scaffold, findsWidgets, reason: 'The app did not reach a page.');

    final router = GoRouter.of(tester.element(scaffold.first));
    // Protected routes redirect to login or terms without an authenticated
    // session. In that state, verify startup instead of treating redirects as
    // page failures.
    if (find.byType(LoginPage).evaluate().isNotEmpty ||
        find.byType(TermsAgreementPage).evaluate().isNotEmpty) {
      expect(find.byType(ErrorWidget), findsNothing);
      expect(tester.takeException(), isNull);
      return;
    }

    const routes = [
      '/terms',
      '/',
      '/search',
      '/notifications',
      '/settings',
      '/activity',
      '/insights',
      '/moderation',
      '/tools',
      '/profile',
      '/favorites',
      '/groups',
      '/avatars',
      '/inventory',
      '/event_calendar',
      '/osc',
      '/credits',
      '/engage_card',
      '/qr_scanner',
      '/user/usr_1d67de93-8afb-48dc-af7d-da7a33834f52',
      '/avatar/avtr_00000000-0000-0000-0000-000000000000',
      '/world/wrld_7ae6171a-4f26-461f-b727-19e60603c1aa',
      '/group/grp_00000000-0000-0000-0000-000000000000',
    ];

    for (final route in routes) {
      router.go(route);
      await _pumpApp(tester, const Duration(seconds: 2));

      expect(
        find.byType(ErrorWidget),
        findsNothing,
        reason: 'An ErrorWidget was rendered for $route.',
      );
    }

    const tabRoutes = [
      '/search',
      '/activity',
      '/insights',
      '/moderation',
      '/tools',
      '/favorites',
      '/inventory',
    ];

    for (final route in tabRoutes) {
      router.go(route);
      await _pumpApp(tester, const Duration(seconds: 1));

      final tabBar = find.byType(TabBar);
      expect(
        tabBar,
        findsOneWidget,
        reason: 'No tab bar was rendered on $route.',
      );
      final tabs = find.descendant(of: tabBar, matching: find.byType(Tab));
      final tabCount = tabs.evaluate().length;
      expect(tabCount, greaterThan(1), reason: 'No usable tabs on $route.');

      for (var index = 0; index < tabCount; index++) {
        final tab = tabs.at(index);
        await tester.ensureVisible(tab);
        await tester.tap(tab);
        await _pumpApp(tester, const Duration(milliseconds: 500));

        expect(
          find.byType(ErrorWidget),
          findsNothing,
          reason: 'A tab interaction rendered an ErrorWidget on $route.',
        );
        expect(
          tester.takeException(),
          isNull,
          reason: 'A tab interaction threw on $route.',
        );
      }
    }

    router.go('/');
    await _pumpApp(tester, const Duration(seconds: 1));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await _pumpApp(tester, const Duration(seconds: 2));

    expect(find.byType(Scaffold), findsWidgets);
    expect(find.byType(ErrorWidget), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpUntilFirstPage(WidgetTester tester) async {
  for (var attempt = 0; attempt < 120; attempt++) {
    await tester.pump(const Duration(milliseconds: 250));
    if (find.byType(Scaffold).evaluate().isNotEmpty) return;
  }
}

Future<void> _pumpApp(WidgetTester tester, Duration duration) async {
  const step = Duration(milliseconds: 250);
  var elapsed = Duration.zero;

  while (elapsed < duration) {
    await tester.pump(step);
    elapsed += step;
  }
}
