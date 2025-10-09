import 'package:expect_better/expect_better.dart';
import 'package:expect_better/src/matchers.dart' as matchers;
import 'package:test/test.dart' as test;

/// Assertion methods
extension IterableBaseAssertionMethods<A extends BaseAssertion<Object?>> on A {
  /// Asserts that [actual] is not empty.
  A isNotEmpty({String? because, Object? when}) =>
      matches(test.isNotEmpty, because: because, when: when);

  /// Asserts that [actual] is empty.
  A isEmpty({String? because, Object? when}) =>
      matches(test.isEmpty, because: because, when: when);

  /// Asserts that [actual] is an [Iterable].
  /// You can also provide additional matchers to check the contents of the
  /// iterable:
  /// - [containingAllOf]: checks that the iterable contains all of the given
  /// items, in any order.
  /// - [containingAllOfInOrder]: checks that the iterable contains all of the
  /// given items, in the given order.
  /// - [containingAnyOf]: checks that the iterable contains any of the given
  /// items.
  /// - [containingNoneOf]: checks that the iterable contains none of the given
  /// items.
  BaseAssertion<Iterable<Object?>> isIterable({
    String? because,
    Object? when,
    Iterable<Object?>? containingAllOf,
    Iterable<Object?>? containingAllOfInOrder,
    Iterable<Object?>? containingAnyOf,
    Iterable<Object?>? containingNoneOf,
  }) =>
      isIterableOf<Object?>(
        because: because,
        when: when,
        containingAllOf: containingAllOf,
        containingAllOfInOrder: containingAllOfInOrder,
        containingAnyOf: containingAnyOf,
        containingNoneOf: containingNoneOf,
      );

  /// Asserts that [actual] is an [Iterable] of elements of type [T].
  /// You can also provide additional matchers to check the contents of the
  /// iterable:
  /// - [containingAllOf]: checks that the iterable contains all of the given
  /// items, in any order.
  /// - [containingAllOfInOrder]: checks that the iterable contains all of the
  /// given items, in the given order.
  /// - [containingAnyOf]: checks that the iterable contains any of the given
  /// items.
  /// - [containingNoneOf]: checks that the iterable contains none of the given
  /// items.
  BaseAssertion<Iterable<T>> isIterableOf<T>({
    String? because,
    Object? when,
    Iterable<T>? containingAllOf,
    Iterable<T>? containingAllOfInOrder,
    Iterable<T>? containingAnyOf,
    Iterable<T>? containingNoneOf,
  }) {
    final typed = isA<Iterable<T>>(because: because, when: when);
    if (containingAllOf != null) {
      typed.containsAllOf(
        containingAllOf,
        because: because,
        when: when,
      );
    }
    if (containingAllOfInOrder != null) {
      typed.containsAllOfInOrder(
        containingAllOfInOrder,
        because: because,
        when: when,
      );
    }
    if (containingAnyOf != null) {
      typed.containsAnyOf(
        containingAnyOf,
        because: because,
        when: when,
      );
    }
    if (containingNoneOf != null) {
      typed.containsNoneOf(
        containingNoneOf,
        because: because,
        when: when,
      );
    }
    return typed;
  }
}

/// Typed assertion methods for [Iterable]s.
extension IterableTypedAssertionMethods<T, A extends BaseAssertion<Iterable<T>>>
    on A {
  /// Asserts that [actual] contains any of the [items].
  BaseAssertion<Iterable<T>> containsAnyOf(
    Iterable<T> items, {
    String? because,
    Object? when,
  }) {
    matches(
      matchers.containsAnyOf(items),
      because: because,
      when: when,
    );
    return this;
  }

  /// Asserts that [actual] contains all of the [items].
  BaseAssertion<Iterable<T>> containsAllOf(
    Iterable<T> items, {
    String? because,
    Object? when,
  }) {
    matches(
      test.containsAll(items),
      because: because,
      when: when,
    );
    return this;
  }

  /// Asserts that [actual] contains all of the [items] in order.
  BaseAssertion<Iterable<T>> containsAllOfInOrder(
    Iterable<T> items, {
    String? because,
    Object? when,
  }) {
    matches(
      test.containsAllInOrder(items),
      because: because,
      when: when,
    );
    return this;
  }

  /// Asserts that [actual] contains none of the [items].
  BaseAssertion<Iterable<T>> containsNoneOf(
    Iterable<T> items, {
    String? because,
    Object? when,
  }) {
    doesNotMatch(
      matchers.containsAnyOf(items),
      because: because,
      when: when,
    );
    return this;
  }
}
