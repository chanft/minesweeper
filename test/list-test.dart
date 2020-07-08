import 'package:test/test.dart';

void main() {
  test('out', () {
    final list = [1, 2, 3];
    int total = 0;
    try {
      for (int i = 0; i < 5; i++) {
        print(list[i]);
        total += list[i];
      }
    } on RangeError catch (e) {
      print('err${e}');
    }

    print('TOTAL: $total');
  });
}
