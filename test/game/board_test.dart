import 'package:minesweeper/src/game/board.dart';
import 'package:test/test.dart';

void main() {
  test('place mines 16', () {
    final board = Board(width: 6, height: 6)..placeMines(16);
    print(board.toJson());
    expect(board.allMineCount, 16);

    int a = 70;
    print(a ~/ 6);
    print(a % 6);
    print(1.isNegative);
    print(0.isNegative);
    print((-1).isNegative);
  });
}
