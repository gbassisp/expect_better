import 'package:expect_better/expect_better.dart';
import 'package:test/test.dart';

// meta - expect that expectThat executes
// it needs to be a failing test
void expectItFails(BaseAssertion<Object?> Function() failingCase) {
  expect(() => failingCase(), throwsA(isA<TestFailure>()));
}
