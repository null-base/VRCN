import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/terms_agreement_page.dart';

void main() {
  testWidgets('agreement button enables after both choices are checked', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: TermsAgreementPage())),
    );

    AdaptiveButton button() =>
        tester.widget<AdaptiveButton>(find.byType(AdaptiveButton));

    expect(button().onPressed, isNull);
    expect(button().useNative, isFalse);

    await tester.tap(find.byType(AdaptiveCheckbox).first);
    await tester.pump();
    expect(button().onPressed, isNull);

    await tester.tap(find.byType(AdaptiveCheckbox).last);
    await tester.pump();
    expect(button().onPressed, isNotNull);

    await tester.tap(
      find.text(
        t.termsAgreement.agreeTerms(title: t.termsAgreement.termsTitle),
      ),
    );
    await tester.pump();
    expect(button().onPressed, isNull);
  });
}
