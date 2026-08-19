import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart';

void main() {
  group('returnsA', () {
    test('matches functions returning the requested type', () {
      expectThat(() => 'hello').returnsA<String>();
      expectThat(() => 42).returnsA<int>();
      expectThat(() async => 42).returnsA<Future<int>>();
      expectThat(() => [1, 2, 3]).returnsA<List<int>>();
    });

    test('tracks function completion before returning a typed value', () {
      var calls = 0;

      expectThat(() {
        calls += 1;
        return 'done';
      }).returnsA<String>();

      expect(calls, 1);
    });
  });
}
