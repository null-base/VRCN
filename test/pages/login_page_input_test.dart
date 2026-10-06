import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/login_page.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';
import 'package:vrchat/services/auth_storage_service.dart';
import 'package:vrchat/theme/app_theme.dart';

class _EmptyAuthStorageService extends AuthStorageService {
  @override
  Future<({String? username, String? password})> getCredentials() async =>
      (username: null, password: null);

  @override
  Future<bool> getRememberLogin() async => false;
}

void main() {
  testWidgets('email hint does not change when the field gains focus', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authStorageProvider.overrideWithValue(_EmptyAuthStorageService()),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const LoginPage()),
      ),
    );

    final emailField = find.byType(TextFormField).first;
    final emailTextField = find.descendant(
      of: emailField,
      matching: find.byType(TextField),
    );
    InputDecoration decoration() =>
        tester.widget<TextField>(emailTextField).decoration!;

    expect(find.text(t.login.email), findsOneWidget);
    expect(decoration().labelText, isNull);
    expect(decoration().hintText, t.login.emailHint);

    await tester.tap(emailField);
    await tester.pump();

    expect(find.text(t.login.email), findsOneWidget);
    expect(decoration().labelText, isNull);
    expect(decoration().hintText, t.login.emailHint);
  });
}
