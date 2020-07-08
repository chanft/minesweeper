import 'dart:math';

import 'board.dart';

class MineGenerator {
  final Board _board;

  MineGenerator(this._board);

  void generateMines(int mineCount) {
    for (int i = 0; i < mineCount; i++) _generateMine();
  }

  void _generateMine() {
    final x = Random().nextInt(_board.width);
    final y = Random().nextInt(_board.height);
    final cell = _board.cell(x, y);

    cell.isBlank ? cell.setMine() : _generateMine();
  }
}
