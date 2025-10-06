import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart';

void main() {
  group('BaseAssertion methods', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('isTrue', () {
      expectThat(true).isTrue();
      _expectItExecutes(() => expectThat(false).isTrue());
    });

    test('isFalse', () {
      expectThat(false).isFalse();
      _expectItExecutes(() => expectThat(true).isFalse());
    });
  });

  group('when', () {
    test('skips when false', () {
      expectThat(false).isTrue(when: false);
    });

    test('skips when function returns false', () {
      expectThat(false).isTrue(when: () => false);
    });

    test('skips when object is falsy', () {
      expectThat(false).isTrue(when: 0);
    });

    test('does not skip when true', () {
      _expectItExecutes(() => expectThat(false).isTrue(when: true));
    });

    test('does not skip when function returns true', () {
      _expectItExecutes(() => expectThat(false).isTrue(when: () => true));
    });

    test('does not skip when object is truthy', () {
      _expectItExecutes(() => expectThat(false).isTrue(when: 1));
    });
  });
}

// meta - expect that expectThat executes
// it needs to be a failing test
void _expectItExecutes(BaseAssertion Function() failingCase) {
  expect(() => failingCase(), throwsA(isA<TestFailure>()));
}
