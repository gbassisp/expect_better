import 'package:expect_better/expect_better.dart';
import 'package:expect_better/src/matchers.dart' as matchers;

/// Assertion methods for [String]s
extension FunctionTypedAssertionMethods<A extends BaseAssertion<Function>>
    on A {
  /// Asserts that [actual] returns normally the expected type.
  BaseAssertion<T> returnsA<T>({
    String? because,
    Object? when,
  }) {
    final matcher = matchers.returnsA<T>() as matchers.ReturnsA<T>;
    matches(
      matcher,
      because: because,
      when: when,
    );
    expectThat(matcher.completed).isTrue(
      because: 'The function did not complete normally',
      when: when,
    );

    return expectThat(matcher.resultAsT).isA<T>(because: because, when: when);
  }
}
