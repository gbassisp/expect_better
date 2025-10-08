import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart';

void main() {
  group('BaseAssertion methods', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('isTrue', () {
      expectThat(true).isTrue();
      _expectItFails(() => expectThat(false).isTrue());
    });

    test('isFalse', () {
      expectThat(false).isFalse();
      _expectItFails(() => expectThat(true).isFalse());
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
      _expectItFails(() => expectThat(false).isTrue(when: true));
    });

    test('does not skip when function returns true', () {
      _expectItFails(() => expectThat(false).isTrue(when: () => true));
    });

    test('does not skip when object is truthy', () {
      _expectItFails(() => expectThat(false).isTrue(when: 1));
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
      _expectItFails(() => expectThat(['1', '2']).isIterableOf<int>());
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
      _expectItFails(
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
      _expectItFails(
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
      _expectItFails(
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

  group('isIterable', () {
    test('accepts an empty iterable', () {
      expectThat(<dynamic>[]).isIterable();
    });

    test('accepts iterables of mixed types', () {
      expectThat([1, 'two', 3.0, true]).isIterable();
    });

    test('accepts iterable containing all items in any order', () {
      expectThat(['a', 2, true]).isIterable(
        containingAllOf: [true, 'a', 2],
      );
    });

    test('accepts iterable containing all items in specified order', () {
      expectThat(['a', 2, true]).isIterable(
        containingAllOfInOrder: ['a', 2, true],
      );
    });

    test('rejects iterable not containing all items in specified order', () {
      _expectItFails(
        () => expectThat(['a', true, 2]).isIterable(
          containingAllOfInOrder: ['a', 2, true],
        ),
      );
    });

    test('accepts iterable containing any of the specified items', () {
      expectThat(['x', 2, 'y']).isIterable(
        containingAnyOf: ['a', 2, 'b'],
      );
    });

    test('rejects iterable containing none of the specified items', () {
      _expectItFails(
        () => expectThat(['x', 'y', 'z']).isIterable(
          containingAnyOf: ['a', 2, 'b'],
        ),
      );
    });

    test('accepts iterable containing none of the specified items', () {
      expectThat(['x', 'y', 'z']).isIterable(
        containingNoneOf: ['a', 2, 'b'],
      );
    });

    test('rejects iterable containing any of the specified items to exclude',
        () {
      _expectItFails(
        () => expectThat(['x', 2, 'z']).isIterable(
          containingNoneOf: ['a', 2, 'b'],
        ),
      );
    });

    test('combines multiple containment checks with mixed types', () {
      expectThat([1, 'two', true, 3.0]).isIterable(
        containingAllOf: [1, 'two'],
        containingAnyOf: [true, false],
        containingNoneOf: ['nope', 4],
      );
    });

    test('accepts non-list iterables', () {
      expectThat({1, 'two', 3.0}).isIterable();
    });

    test('rejects non-iterable types', () {
      _expectItFails(() => expectThat(42).isIterable());
      _expectItFails(() => expectThat('not an iterable').isIterable());
      _expectItFails(() => expectThat(true).isIterable());
    });
  });

  group('isIterable chained methods', () {
    test('containsAnyOf accepts any of the specified items', () {
      return expectThat([1, 4, 5]).isIterableOf<int>().containsAnyOf(
        [1, 2, 3],
      ).containsAnyOf([1]).containsAnyOf([5]).containsAnyOf([4]);
    });

    test('containsAnyOf rejects none of the specified items', () {
      _expectItFails(
        () =>
            expectThat([4, 5, 6]).isIterableOf<int>().containsAnyOf([1, 2, 3]),
      );
    });
    test('containsAnyOf skips when false', () {
      expectThat([4, 5, 6])
          .isIterableOf<int>()
          .containsAnyOf([1, 2, 3], when: false);
    });
    test('containsAllOf accepts all of the specified items', () {
      expectThat([1, 2, 3]).isIterableOf<int>().containsAllOf([1, 2]);
    });
    test('containsAllOf rejects missing any of the specified items', () {
      _expectItFails(
        () => expectThat([1, 2, 3]).isIterableOf<int>().containsAllOf([1, 4]),
      );
    });
    test('containsAllOf skips when false', () {
      expectThat([1, 2, 3])
          .isIterableOf<int>()
          .containsAllOf([1, 4], when: false);
    });
  });
}

// meta - expect that expectThat executes
// it needs to be a failing test
void _expectItFails(BaseAssertion Function() failingCase) {
  expect(() => failingCase(), throwsA(isA<TestFailure>()));
}
