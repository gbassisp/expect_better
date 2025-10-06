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
    test.expect(actual, matcher, reason: because, skip: _skip(when));
    return this;
  }

  String? _skip(Object? when) {
    if (when == null) {
      return null;
    }
    if (when is bool && !when) {
      return 'Skipped because when is false';
    }
    if (when is bool Function() && !when()) {
      return 'Skipped because when returns false';
    }
    if (when.isFalsy) {
      return 'Skipped because when is falsy';
    }
    return null;
  }

  /// Asserts that [actual] is `true`.
  BaseAssertion isTrue({String? because, Object? when}) =>
      matches(test.isTrue, because: because, when: when);

  /// Asserts that [actual] is `false`.
  BaseAssertion isFalse({String? because, Object? when}) =>
      matches(test.isFalse, because: because, when: when);

  /// Asserts that [actual] is `null`.
  BaseAssertion isNull({String? because, Object? when}) =>
      matches(test.isNull, because: because, when: when);

  /// Asserts that [actual] is not `null`.
  BaseAssertion isNotNull({String? because, Object? when}) =>
      matches(test.isNotNull, because: because, when: when);

  /// Asserts that [actual] is not empty.
  BaseAssertion isNotEmpty({String? because, Object? when}) =>
      matches(test.isNotEmpty, because: because, when: when);

  /// Asserts that [actual] is empty.
  BaseAssertion isEmpty({String? because, Object? when}) =>
      matches(test.isEmpty, because: because, when: when);

  /// Asserts that [actual] is truthy.
  BaseAssertion isTruthy({String? because, Object? when}) {
    expectThat(actual.isTruthy).isTrue(because: because, when: when);
    return this;
  }

  /// Asserts that [actual] is falsy.
  BaseAssertion isFalsy({String? because, Object? when}) {
    expectThat(actual.isFalsy).isTrue(because: because, when: when);
    return this;
  }
}
