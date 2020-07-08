import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:minesweeper/src/game/cell/board_cell.dart';

import 'cell/cell.dart';

part 'board.g.dart';

class Board {
  final int width;
  final int height;

  final List<List<Cell>> _cells;

  Board({@required this.width, @required this.height})
      : _cells =
            List.generate(height, (_) => List.generate(width, (_) => Cell()));

  Board._fromJsonModel(_BoardJson model)
      : width = model.width,
        height = model.height,
        _cells = model.cells;

  Map<String, dynamic> toJson() =>
      _BoardJson(width: width, height: height, cells: _cells).toJson();

  factory Board.fromJson(Map<String, dynamic> json) =>
      Board._fromJsonModel(_BoardJson.fromJson(json));

//  void placeMines(int mineCount) {
//    for (int i = 0; i < mineCount; i++) _placeMine();
//  }
//
//  void _placeMine() {
//    final x = Random().nextInt(width);
//    final y = Random().nextInt(height);
//    final cell = _cells[y][x];
//
//    cell.isBlank ? cell.setMine() : _placeMine();
//  }

  void findBlankCell(int x, int y) {
    final c = cell(x, y);
    if (c.isCovered) {
      c.uncover();

      if (c.isBlank && aroundMineCount(x, y) == 0) {
        _cellAround(x, y, (_, x, y) => findBlankCell(x, y));
      }
    }
  }

  int aroundMineCount(int x, int y) {
//    _cells[0].firstWhere((element) => Cell() == element).
    int count = 0;
    _cellAround(x, y, (cell, _, __) {
      if (cell.hasMine) count++;
    });

    return count;
  }

  void _cellAround(
    int x,
    int y,
    void Function(Cell cell, int x, int y) validAround,
  ) {
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        final ax = x + i;
        final ay = y + j;
        final c = cell(ax, ay);
        if (c == null || (ax == x && ay == y)) continue;
        validAround(c, ax, ay);
      }
    }
  }

  Cell cell(int x, int y) {
    try {
      BoardCell(Point(x, y), _cells[y][x]);
//      return _cells[y][x];
    } on RangeError {
      return null;
    }
  }

  void findAllMines() {
    flattenCells.forEach((cell) {
      if (cell.hasMine) cell.uncover();
    });
  }

  int get remainingMineCount {
    final foundOrFlaggedCount = flattenCells
        .where((cell) => (cell.hasMine && cell.isUncovered) || cell.isFlagged)
        .length;

    return allMineCount - foundOrFlaggedCount;
  }

  int get allMineCount => flattenCells.where((cell) => cell.hasMine).length;

  int get uncoveredCellCount =>
      flattenCells.where((cell) => cell.isUncovered).length;

  bool get isWon => !anyUncoveredMine && allMineCount == coveredCellCount;

  bool get isDefeated => anyUncoveredMine;

  int get coveredCellCount =>
      flattenCells.where((cell) => cell.isCovered).length;

  bool get anyUncoveredMine =>
      flattenCells.any((element) => element.hasMine && element.isUncovered);

  Iterable<Cell> get flattenCells => _cells.expand((e) => e);
}

@JsonSerializable(explicitToJson: true)
class _BoardJson {
  _BoardJson({this.width, this.height, this.cells});

  final int width;
  final int height;
//  final Cell cells;
  final List<List<Cell>> cells;

  factory _BoardJson.fromJson(Map<String, dynamic> json) =>
      _$_BoardJsonFromJson(json);

  Map<String, dynamic> toJson() => _$_BoardJsonToJson(this);

//  Board toBoard() =>
}
