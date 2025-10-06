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

  group('isIterableOf', () {
    test('accepts an empty iterable', () {
      expectThat(<int>[]).isIterableOf<int>();
    });

    test('accepts an iterable of the correct type', () {
      expectThat([1, 2, 3]).isIterableOf<int>();
    });

    test('rejects an iterable of the wrong type', () {
      _expectItExecutes(() => expectThat(['1', '2']).isIterableOf<int>());
    });

    test('accepts iterable containing all items in any order', () {
      expectThat([3, 1, 2]).isIterableOf<int>(
        containingAllOf: [1, 2, 3],
      );
    });

    test('accepts iterable containing all items in specified order', () {
      expectThat([1, 2, 3]).isIterableOf<int>(
        containingAllOfInOrder: [1, 2, 3],
      );
    });

    test('rejects iterable not containing all items in specified order', () {
      _expectItExecutes(
        () => expectThat([3, 2, 1]).isIterableOf<int>(
          containingAllOfInOrder: [1, 2, 3],
        ),
      );
    });

    test('accepts iterable containing any of the specified items', () {
      expectThat([1, 4, 5]).isIterableOf<int>(
        containingAnyOf: [1, 2, 3],
      );
    });

    test('rejects iterable containing none of the specified items', () {
      _expectItExecutes(
        () => expectThat([4, 5, 6]).isIterableOf<int>(
          containingAnyOf: [1, 2, 3],
        ),
      );
    });

    test('accepts iterable containing none of the specified items', () {
      expectThat([4, 5, 6]).isIterableOf<int>(
        containingNoneOf: [1, 2, 3],
      );
    });

    test('rejects iterable containing any of the specified items to exclude',
        () {
      _expectItExecutes(
        () => expectThat([1, 4, 5]).isIterableOf<int>(
          containingNoneOf: [1, 2, 3],
        ),
      );
    });

    test('combines multiple containment checks', () {
      expectThat([1, 2, 3, 4]).isIterableOf<int>(
        containingAllOf: [1, 2],
        containingAnyOf: [3, 5],
        containingNoneOf: [6, 7],
      );
    });
  });
}

// meta - expect that expectThat executes
// it needs to be a failing test
void _expectItExecutes(BaseAssertion Function() failingCase) {
  expect(() => failingCase(), throwsA(isA<TestFailure>()));
}
