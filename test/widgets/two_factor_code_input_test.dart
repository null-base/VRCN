import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/widgets/two_factor_code_input.dart';

void main() {
  testWidgets('accepts a complete code through one autofill field', (
    tester,
  ) async {
    final controller = TextEditingController();
    String? completedCode;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TwoFactorCodeInput(
            controller: controller,
            onCompleted: (code) => completedCode = code,
          ),
        ),
      ),
    );

    final field = find.byType(TextField);
    expect(field, findsOneWidget);

    await tester.enterText(field, '123456');
    await tester.pump();

    expect(controller.text, '123456');
    expect(completedCode, '123456');

    controller.dispose();
  });

  testWidgets('advertises iOS one-time-code autofill on the real field', (
    tester,
  ) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TwoFactorCodeInput(
            controller: controller,
            onCompleted: (_) {},
          ),
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.autofillHints, const [AutofillHints.oneTimeCode]);

    controller.dispose();
  });

  testWidgets('light theme keeps the code boxes visible above the input', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 350,
              child: TwoFactorCodeInput(
                controller: controller,
                onCompleted: (_) {},
              ),
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), '123');
    await tester.pump();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.decoration?.filled, isFalse);
    expect(field.decoration?.enabledBorder, InputBorder.none);
    expect(field.decoration?.focusedBorder, InputBorder.none);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(
      tester.widget<Text>(find.text('1')).style?.color,
      AppTheme.light.colorScheme.primary,
    );

    controller.dispose();
  });
}
