import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  group('hasLength', () {
    test('matches iterables with the expected length', () {
      expectThat(<String>['a', 'b', 'c']).hasLength(3);
      expectThat(<int>[1, 2, 3, 4]).hasLength(4);
      expectThat(<String>{'a', 'b'}).hasLength(2);
      expectThat(<int>[]).hasLength(0);
      expectItFails(() => expectThat(<int>[]).hasLength(1));
    });
  });
}
