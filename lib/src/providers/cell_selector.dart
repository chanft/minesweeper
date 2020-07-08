import 'package:flutter/cupertino.dart';
import 'package:minesweeper/src/game/board.dart';

import '../game/cell/cell.dart';

class CellSelector with ChangeNotifier {
  Board _board;

  int _selectedX;
  int _selectedY;

  void makeBoard({
    @required int width,
    @required int height,
    @required int mineCount,
  }) {
    _board = Board(width: width, height: height);
//      ..placeMines(mineCount);
//    notifyListeners();
  }

  Cell cell(int x, int y) => _board.cell(x, y);

  void selectCell(int x, int y) {
    _selectedX = x;
    _selectedY = y;
    notifyListeners();
  }

  void flag() {
    print('flag');
    final c = cell(_selectedX, _selectedY);
    c.isFlagged ? c.unflag() : c.flag();
    notifyListeners();
  }

  void find() {
    _board.findBlankCell(_selectedX, _selectedY);
    unselectCell();
  }

  void unselectCell() {
    _selectedX = null;
    _selectedY = null;
    notifyListeners();
  }

  bool isSelectedAt(int x, int y) => _selectedX == x && selectedY == y;

  int get width => _board?.width;
  int get height => _board?.height;

  int get selectedX => _selectedX;
  int get selectedY => _selectedY;

  bool get isSelected => _selectedX != null && _selectedY != null;

  Board get board => _board;
}
