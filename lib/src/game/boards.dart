import 'board.dart';

class Boards {
  static Board newBeginnerBoard() => Board(width: 7, height: 7);
  static Board newIntermediateBoard() => Board(width: 11, height: 11);
  static Board newExpertBoard() => Board(width: 15, height: 15);
}
