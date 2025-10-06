import 'package:expect_better/expect_better.dart';

void main() {
  expectThat('something').isTruthy().isNotEmpty();
  expectThat(null).isFalsy();
}
