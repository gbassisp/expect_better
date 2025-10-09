import 'package:expect_better/expect_better.dart';
import 'package:lean_extensions/lean_extensions.dart';
import 'package:meta/meta.dart';

@internal
extension InternalBaseAssertionMethods<T> on BaseAssertion<T> {
  String? skipReason(Object? when) {
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

  bool skip(Object? when) {
    return skipReason(when) != null;
  }

  // BaseAssertion<T> lazyMatches(
  //   test.Matcher Function(T value) matcher, {
  //   String? because,
  //   Object? when,
  // }) {
  //   if (skip(when)) {
  //     return BaseAssertion<T>.never();
  //   }
  //   return matches(
  //     matcher(actual as T),
  //     because: because,
  //     when: when,
  //   );
  // }
}
