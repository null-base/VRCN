import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/widgets/app_bar.dart';

void main() {
  testWidgets('home header displays the app icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AppHeaderLogo())),
    );

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, AssetImage(Assets.icons.icon.path));
    expect(image.width, 36);
    expect(image.height, 36);
    expect(tester.takeException(), isNull);
  });
}
