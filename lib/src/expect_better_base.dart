import 'package:expect_better/src/expect_better_internal.dart';
import 'package:expect_better/src/matchers.dart' as matchers;
import 'package:test/test.dart' as test;

/// Starts an expectation chain with the given [actual] value.
BaseAssertion<T> expectThat<T>(T actual) {
  return BaseAssertion<T>(actual);
}

/// A typed expectation that provides type-specific assertion methods.
class BaseAssertion<T> {
  /// Creates an instance of [BaseAssertion].
  BaseAssertion(
    this.actual, {
    this.preconditionSkip,
    this.negate = false,
  });

  /// Creates an instance of [BaseAssertion] that will never run any
  /// assertions, because it failed a precondition.
  factory BaseAssertion.never() =>
      BaseAssertion<T>(null as T?, preconditionSkip: true);

  /// The actual value being tested.
  final T? actual;

  /// If true, all assertions will be skipped.
  final bool? preconditionSkip;

  /// If true, all assertions are negated.
  final bool negate;

  /// Passes [actual] to an assertion function
  BaseAssertion<T> satisfies(
    bool Function(T actual) assertion, {
    String? because,
    Object? when,
  }) {
    if (skip(when)) {
      return BaseAssertion<T>.never();
    }

    final a = actual;
    if (a is! T) {
      fail('not the expected type');
    }
    expectThat(assertion(a)).isTrue(because: because, when: when);

    return this;
  }

  /// wrapper for [fail()] from the test library
  Never fail(String reason) => test.fail(reason);
}

/// Assertion methods
extension BaseAssertionMethods<A extends BaseAssertion<Object?>> on A {
  /// Asserts that [actual] matches the given [matcher].
  ///
  /// This is the most basic assertion method, which is a direct wrapper around
  /// `package:test`'s [test.expect] function. All other assertion methods are
  /// built on top of this one.
  A matches(test.Matcher matcher, {String? because, Object? when}) {
    test.expect(
      actual,
      matcher,
      reason: because,
      skip: skipReason(when),
    );
    return this;
  }

  /// Asserts that [actual] does not match the given [matcher].
  A doesNotMatch(
    test.Matcher matcher, {
    String? because,
    Object? when,
  }) {
    matches(
      test.isNot(matcher),
      because: because,
      when: when,
    );
    return this;
  }

  /// Asserts that [actual] is `true`.
  A isTrue({String? because, Object? when}) =>
      matches(test.isTrue, because: because, when: when);

  /// Asserts that [actual] is `false`.
  A isFalse({String? because, Object? when}) =>
      matches(test.isFalse, because: because, when: when);

  /// Asserts that [actual] is `null`.
  A isNull({String? because, Object? when}) =>
      matches(test.isNull, because: because, when: when);

  /// Asserts that [actual] is not `null`.
  A isNotNull({String? because, Object? when}) =>
      matches(test.isNotNull, because: because, when: when);

  /// Asserts that [actual] is truthy.
  A isTruthy({String? because, Object? when}) {
    matches(matchers.isTruthy, because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is falsy.
  A isFalsy({String? because, Object? when}) {
    matches(matchers.isFalsy, because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is of type [T].
  BaseAssertion<T> isA<T>({String? because, Object? when}) {
    matches(test.isA<T>(), because: because, when: when);
    if (skip(when)) {
      return BaseAssertion.never();
    }
    return BaseAssertion(actual as T);
  }

  /// Asserts that [actual] is not of type [T].
  A isNotA<T>({String? because, Object? when}) {
    doesNotMatch(test.isA<T>(), because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is identical to [other].
  A isIdenticalTo(Object? other, {String? because, Object? when}) {
    matches(test.same(other), because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is not identical to [other].
  A isNotIdenticalTo(Object? other, {String? because, Object? when}) {
    doesNotMatch(test.same(other), because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is equal to [other].
  A isEqualTo(Object? other, {String? because, Object? when}) {
    matches(test.equals(other), because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is not equal to [other].
  A isNotEqualTo(Object? other, {String? because, Object? when}) {
    doesNotMatch(test.equals(other), because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is equal to [other].
  A isEqualButNotIdenticalTo(Object? other, {String? because, Object? when}) {
    matches(matchers.equalsButNotSameAs(other), because: because, when: when);
    return this;
  }
}
