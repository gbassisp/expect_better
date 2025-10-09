import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart' as test;

/// Assertion methods
extension StringBaseAssertionMethods<A extends BaseAssertion<Object?>> on A {
  /// Asserts that [actual] is a [String].
  BaseAssertion<String> isString({String? because, Object? when}) {
    return isA<String>(because: because, when: when);
  }
}

/// Assertion methods for [String]s
extension StringTypedAssertionMethods<A extends BaseAssertion<String>> on A {
  /// Asserts that [actual] is not empty.
  A isNotEmpty({String? because, Object? when}) =>
      matches(test.isNotEmpty, because: because, when: when);

  /// Asserts that [actual] is empty.
  A isEmpty({String? because, Object? when}) =>
      matches(test.isEmpty, because: because, when: when);

  /// Asserts that [actual] starts with the given [prefix].
  BaseAssertion<String> startsWith(
    String prefix, {
    String? because,
    Object? when,
  }) {
    return matches(
      test.startsWith(prefix),
      because: because,
      when: when,
    );
  }

  /// Asserts that [actual] ends with the given [suffix].
  BaseAssertion<String> endsWith(
    String suffix, {
    String? because,
    Object? when,
  }) {
    return matches(
      test.endsWith(suffix),
      because: because,
      when: when,
    );
  }
}
