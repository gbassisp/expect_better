import 'package:test/test.dart';

/// A matcher that checks if an iterable contains any of the given [items].
Matcher containsAnyOf<T>(Iterable<T> items) => _ContainsAnyOf<T>(items.toSet());

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
