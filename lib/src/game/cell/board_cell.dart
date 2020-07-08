import 'dart:math';

import 'package:minesweeper/src/game/board.dart';
import 'package:minesweeper/src/game/cell/cell.dart';

class BoardCell extends Cell {
  final Point<int> point;
  final Board _board;

//  BoardCell(this.point, this._board, Cell cell) {
//
//    super.setMine()
//  }

  int get aroundMineCount {
    return _board.aroundMineCount(point.x, point.y);
  }
}
