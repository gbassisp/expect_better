import 'package:lean_extensions/lean_extensions.dart';
import 'package:test/test.dart' as test;

/// Checks if you are awesome. Spoiler: you are.
abstract class BaseAssertion {
  /// Creates an instance of [BaseAssertion].
  BaseAssertion(this.actual);

  /// The actual value being tested.
  Object? actual;
}

class _Expectation extends BaseAssertion {
  _Expectation(Object? actual) : super(actual);
}

/// Starts an expectation chain with the given [actual] value.
BaseAssertion expectThat(Object? actual) {
  return _Expectation(actual);
}

/// Assertion methods
extension BoolExpectation on BaseAssertion {
  /// Asserts that [actual] matches the given [matcher].
  ///
  /// This is the most basic assertion method, which is a direct wrapper around
  /// `package:test`'s [test.expect] function. All other assertion methods are
  /// built on top of this one.
  BaseAssertion matches(test.Matcher matcher, {String? because, Object? when}) {
    if (when != null) {
      if (when is bool) {
        if (!when) {
          return this;
        }
      } else if (when is bool Function()) {
        if (!when()) {
          return this;
        }
      } else {
        throw ArgumentError.value(
          when,
          'when',
          'Must be a bool or a Function returning bool.',
        );
      }
    }
    test.expect(actual, matcher, reason: because);
    return this;
  }

  /// Asserts that [actual] is `true`.
  BaseAssertion isTrue({String? because}) =>
      matches(test.isTrue, because: because);

  /// Asserts that [actual] is `false`.
  BaseAssertion isFalse({String? because}) =>
      matches(test.isFalse, because: because);

  /// Asserts that [actual] is `null`.
  BaseAssertion isNull({String? because}) =>
      matches(test.isNull, because: because);

  /// Asserts that [actual] is not `null`.
  BaseAssertion isNotNull({String? because}) =>
      matches(test.isNotNull, because: because);

  /// Asserts that [actual] is not empty.
  BaseAssertion isNotEmpty({String? because}) =>
      matches(test.isNotEmpty, because: because);

  /// Asserts that [actual] is empty.
  BaseAssertion isEmpty({String? because}) =>
      matches(test.isEmpty, because: because);

  /// Asserts that [actual] is truthy.
  BaseAssertion isTruthy({String? because}) {
    test.expect(actual.isTruthy, test.isTrue, reason: because);
    return this;
  }

  /// Asserts that [actual] is falsy.
  BaseAssertion isFalsy({String? because}) {
    test.expect(actual.isFalsy, test.isFalse, reason: because);
    return this;
  }
}
