import 'package:expect_better/expect_better.dart';

/// Assertion methods
extension StringBaseAssertionMethods<A extends BaseAssertion> on A {
  /// Asserts that [actual] is a [String].
  TypedAssertion<String> isString({String? because, Object? when}) {
    return isA<String>(because: because, when: when);
  }
}
