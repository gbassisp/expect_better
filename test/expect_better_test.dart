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

  group('isIterableOf edge cases', () {
    test('accepts null in Iterable<Object?>', () {
      expectThat([1, null, 3]).isIterableOf<Object?>();
    });

    test('rejects null in non-nullable Iterable', () {
      _expectItFails(() => expectThat([1, null, 3]).isIterableOf<int>());
    });

    test('accepts empty iterable with complex type', () {
      expectThat(<List<int>>[]).isIterableOf<List<int>>();
    });

    test('handles nested iterables', () {
      expectThat([
        [1, 2],
        [3, 4],
      ]).isIterableOf<List<int>>();
      _expectItFails(
        () => expectThat([
          [1, 2],
          ['3', '4'],
        ]).isIterableOf<List<int>>(),
      );
    });
  });

  group('matchers', () {
    group('isTruthy', () {
      test('matches truthy values', () {
        expectThat(1).isTruthy();
        expectThat(true).isTruthy();
        expectThat([1]).isTruthy();
        expectThat('text').isTruthy();
      });

      test('does not match falsy values', () {
        _expectItFails(() => expectThat(0).isTruthy());
        _expectItFails(() => expectThat(false).isTruthy());
        _expectItFails(() => expectThat('').isTruthy());
        _expectItFails(() => expectThat(<int>[]).isTruthy());
        _expectItFails(() => expectThat(null).isTruthy());
      });
    });

    group('isFalsy', () {
      test('matches falsy values', () {
        expectThat(0).isFalsy();
        expectThat(false).isFalsy();
        expectThat('').isFalsy();
        expectThat(<int>[]).isFalsy();
        expectThat(null).isFalsy();
      });

      test('does not match truthy values', () {
        _expectItFails(() => expectThat(1).isFalsy());
        _expectItFails(() => expectThat(true).isFalsy());
        _expectItFails(() => expectThat([1]).isFalsy());
        _expectItFails(() => expectThat('text').isFalsy());
      });
    });
  });

  group('when variations', () {
    test('skips when function returns false', () {
      expectThat(false).isTrue(when: () => false);
    });

    test('skips when value is falsy', () {
      expectThat(false).isTrue(when: 0);
      expectThat(false).isTrue(when: '');
      expectThat(false).isTrue(when: []);
    });

    test('executes when value is null', () {
      _expectItFails(() => expectThat(false).isTrue(when: null));
    });

    test('executes when function returns true', () {
      _expectItFails(() => expectThat(false).isTrue(when: () => true));
    });

    test('executes when value is truthy', () {
      _expectItFails(() => expectThat(false).isTrue(when: 1));
      _expectItFails(() => expectThat(false).isTrue(when: 'text'));
      _expectItFails(() => expectThat(false).isTrue(when: [1]));
    });
  });

  group('isIterable advanced scenarios', () {
    test('handles async iterables', () {
      expectThat(Stream<int>.fromIterable([1, 2, 3])).isA<Stream<int>>();
    });

    test('handles custom iterable types', () {
      const customIterable = _CustomIterable([1, 2, 3]);
      expectThat(customIterable).isIterableOf<int>(
        containingAllOf: [1, 2, 3],
      );
    });

    test('accepts empty map entries as iterable', () {
      final map = <String, int>{};
      expectThat(map.entries).isIterable();
    });

    test('works with map entries containing mixed types', () {
      final map = {'a': 1, 'b': 'two', 'c': true};
      expectThat(map.entries).isIterable();
    });
  });

  group('isIterableOf with complex types', () {
    test('works with custom objects', () {
      final items = [
        const _TestObject(1),
        const _TestObject(2),
        const _TestObject(3),
      ];
      expectThat(items).isIterableOf<_TestObject>();
    });

    test('handles inheritance correctly', () {
      final items = [
        _ChildTestObject(1),
        _ChildTestObject(2),
      ];
      expectThat(items).isIterableOf<_TestObject>(
        because: 'ChildTestObject is a TestObject',
      );
      expectThat(items).isIterableOf<_ChildTestObject>();
    });

    test('handles Future type correctly', () {
      final futures = [
        Future.value(1),
        Future.value(2),
      ];
      expectThat(futures).isIterableOf<Future<int>>();
    });
  });

  group('isIterableOf with containment combinations', () {
    test('combines allOf and anyOf with partial overlap', () {
      expectThat([1, 2, 3, 4]).isIterableOf<int>(
        containingAllOf: [1, 2],
        containingAnyOf: [3, 5],
      );
    });

    test('combines allOf and noneOf with no overlap', () {
      expectThat([1, 2, 3]).isIterableOf<int>(
        containingAllOf: [1, 2],
        containingNoneOf: [4, 5],
      );
    });

    test('fails when containment requirements conflict', () {
      _expectItFails(
        () => expectThat([1, 2, 3]).isIterableOf<int>(
          containingAllOf: [1, 2],
          containingNoneOf: [1, 4],
          because: 'Conflicts with containingAllOf',
        ),
      );
    });

    test('handles empty iterables in containment checks', () {
      expectThat(<int>[]).isIterableOf<int>(
        containingNoneOf: [1, 2, 3],
      );
      _expectItFails(
        () => expectThat(<int>[]).isIterableOf<int>(
          containingAnyOf: [1, 2, 3],
        ),
      );
    });
  });

  group('method discoverability', () {
    test('method chaining upcasts types', () {
      const Object str = 'a string';
      expect(
        () {
          // the test shows the method is not available until upcast
          // ignore: avoid_dynamic_calls
          (expectThat(str) as dynamic).startsWith('a').endsWith('string');
        },
        throwsNoSuchMethodError,
      );

      expectThat(str).isA<String>().startsWith('a').endsWith('string');
    });
  });
}

class _TestObject {
  const _TestObject(this.value);
  final int value;
}

class _ChildTestObject extends _TestObject {
  _ChildTestObject(super.value);
}

class _CustomIterable extends Iterable<int> {
  const _CustomIterable(this._items);
  final List<int> _items;

  @override
  Iterator<int> get iterator => _items.iterator;
}

// meta - expect that expectThat executes
// it needs to be a failing test
void _expectItFails(BaseAssertion<Object?> Function() failingCase) {
  expect(() => failingCase(), throwsA(isA<TestFailure>()));
}
