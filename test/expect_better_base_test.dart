import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  group('equals but not identical', () {
    test('matches non-canonicalized value object', () {
      // canonicalized
      const value1 = <int>[1];
      const value2 = <int>[1];
      // non-canonical
      final value3 = <int>[1];
      final value4 = <int>[1];

      expectThat(value3).isEqualTo(value4);
      expectThat(value3).isNotIdenticalTo(value4);
      expectThat(value3).isEqualButNotIdenticalTo(value4);
      expectItFails(() => expectThat(value1).isEqualButNotIdenticalTo(value2));
    });
  });
}
