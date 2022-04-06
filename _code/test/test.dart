
import 'package:flutter_test/flutter_test.dart';

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

void main() {
  /*
https://pub.dev/packages/test
  test

테스트에 대한 설명과 실제 테스트 코드를 적습니다.
시간 제한(timeout) 이나 테스트 환경 (브라우저, OS) 등도 적어줄 수 있습니다.
expect

expect(실제값, 기대값)
테스트의 기대값과 실제값을 비교합니다.
다른 언어의 assert 와 동일하다고 보시면 됩니다.
setup

테스트를 시작하기 전에 설정을 해줍니다.
테스트 단위 하나마다 실행됩니다. ( test() 함수 하나가 테스트 단위 하나에요. 한 파일에 여러 test() 가 있으면 여러번 실행됩니다. )
setupAll

테스트 시작하기 전에 설정을 해줍니다.
파일 하나에 한번만 실행됩니다. (데이터 베이스 설정할 때 쓰기 좋겠죠)
teardown

테스트를 마치고 할 작업을 정해줍니다.
테스트 단위 하나마다 실행됩니다 ( setup() 함수랑 동일합니다 )
teardownAll()

테스트를 마치고 할 작업을 정해줍니다.
파일 하나에 한번만 실행됩니다. ( setupAll() 함수랑 동일합니다 )

   */

  group('Counter', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
/*

      expect(FieldValidator.validateEmail(email2), true , reason: '# is a not valid character');
 */
/*
//Future의 값은 아래처럼 completion을 써야 비교 가능하다.
void main() {
  test('new Future.value() returns the value with completion', () {
    var value = Future.value(10);
    expect(value, completion(10));
  });
}
 */