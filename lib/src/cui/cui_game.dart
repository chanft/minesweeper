import '../game/board.dart';

void main() {
  final board = Board(width: 8, height: 8)..placeMines(8);
}

void printBoard() {}

class CuiGame {
  final Board _board;

  CuiGame() : _board = Board(width: 8, height: 8)..placeMines(8);

  printBoard() {
    print(' ABCDEFGH');
  }
}
