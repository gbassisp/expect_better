import 'package:lean_extensions/lean_extensions.dart';
import 'package:test/test.dart';

/// A matcher that checks if two objects are equal but not the same instance.
Matcher equalsButNotSameAs(Object? other) =>
    allOf(equals(other), isNot(same(other)));

/// A matcher that checks if an iterable contains any of the given [items].
Matcher containsAnyOf<T>(Iterable<T> items) => _ContainsAnyOf<T>(items.toSet());

/// A matcher that checks if a value is "truthy".
Matcher get isTruthy => _IsTruthy();

/// A matcher that checks if a value is "falsy".
Matcher get isFalsy => _IsFalsy();

class _ContainsAnyOf<T> extends Matcher {
  _ContainsAnyOf(this._items);
  final Set<T> _items;

  @override
  Description describe(Description description) {
    return description.add('contains any of $_items');
  }

  @override
  bool matches(Object? item, Map<Object?, Object?> matchState) {
    if (item is Iterable<T>) {
      for (final element in item) {
        if (_items.contains(element)) {
          return true;
        }
      }
    }
    return false;
  }
}

class _IsTruthy extends Matcher {
  @override
  Description describe(Description description) {
    return description.add('is truthy');
  }

  @override
  bool matches(Object? item, Map<Object?, Object?> matchState) {
    return item.isTruthy;
  }
}

class _IsFalsy extends Matcher {
  @override
  Description describe(Description description) {
    return description.add('is falsy');
  }

  @override
  bool matches(Object? item, Map<Object?, Object?> matchState) {
    return item.isFalsy;
  }
}
