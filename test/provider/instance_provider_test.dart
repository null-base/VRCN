import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/provider/instance_provider.dart';

void main() {
  test('only world instance locations are fetchable', () {
    expect(isInstanceLocation('traveling'), isFalse);
    expect(isInstanceLocation('private'), isFalse);
    expect(isInstanceLocation('offline'), isFalse);
    expect(
      isInstanceLocation('wrld_example:12345~region(jp)'),
      isTrue,
    );
  });
}
