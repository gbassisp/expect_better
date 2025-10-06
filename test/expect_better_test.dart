import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart';

void main() {
  group('BaseAssertion methods', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('isTrue', () {
      expectThat(true).isTrue();
      expect(() => expectThat(false).isTrue(), throwsA(isA<TestFailure>()));
    });

    test('isFalse', () {
      expectThat(false).isFalse();
      expect(() => expectThat(true).isFalse(), throwsA(isA<TestFailure>()));
    });
  });
}
