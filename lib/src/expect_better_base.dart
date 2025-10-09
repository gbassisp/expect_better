import 'package:expect_better/src/matchers.dart' as matchers;
import 'package:lean_extensions/lean_extensions.dart';
import 'package:test/test.dart' as test;

/// Checks if you are awesome. Spoiler: you are.
abstract class BaseAssertion {
  /// Creates an instance of [BaseAssertion].
  BaseAssertion(this.actual, {this.preconditionSkip, this.negate = false});

  /// The actual value being tested.
  final Object? actual;

  /// If true, all assertions will be skipped.
  final bool? preconditionSkip;

  /// If true, all assertions are negated.
  final bool negate;
}

/// A typed expectation that provides type-specific assertion methods.
class TypedAssertion<T> extends BaseAssertion {
  /// Creates an instance of [TypedAssertion].
  TypedAssertion(T actual, {bool? preconditionSkip, bool negate = false})
      : super(
          actual,
          preconditionSkip: preconditionSkip,
          negate: negate,
        );

  /// Creates an instance of [TypedAssertion] that will never run any
  /// assertions, because it failed a precondition.
  TypedAssertion.never()
      : super(
          null,
          preconditionSkip: true,
          negate: false,
        );
}

/// Starts an expectation chain with the given [actual] value.
TypedAssertion<T> expectThat<T>(T actual) {
  return TypedAssertion<T>(actual);
}

/// Assertion methods
extension BaseAssertionMethods<A extends BaseAssertion> on A {
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
      skip: _skipReason(when),
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

  String? _skipReason(Object? when) {
    if (preconditionSkip ?? false) {
      return 'Skipped because of a precondition';
    }
    if (when == null) {
      return null;
    }
    if (when is bool && !when) {
      return 'Skipped because when is false';
    }
    if (when is bool Function() && !when()) {
      return 'Skipped because when returns false';
    }
    if (when is Object? Function()) {
      final result = when();
      if (result.isFalsy && result != null) {
        return 'Skipped because when returns falsy value: $result';
      }
    }
    if (when.isFalsy) {
      return 'Skipped because when is falsy: $when';
    }
    return null;
  }

  bool _skip(Object? when) {
    return _skipReason(when) != null;
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

  /// Asserts that [actual] is not empty.
  A isNotEmpty({String? because, Object? when}) =>
      matches(test.isNotEmpty, because: because, when: when);

  /// Asserts that [actual] is empty.
  A isEmpty({String? because, Object? when}) =>
      matches(test.isEmpty, because: because, when: when);

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
  TypedAssertion<T> isA<T>({String? because, Object? when}) {
    matches(test.isA<T>(), because: because, when: when);
    if (_skip(when)) {
      return TypedAssertion.never();
    }
    return TypedAssertion(actual as T);
  }

  /// Asserts that [actual] is not of type [T].
  A isNotA<T>({String? because, Object? when}) {
    doesNotMatch(test.isA<T>(), because: because, when: when);
    return this;
  }
}
