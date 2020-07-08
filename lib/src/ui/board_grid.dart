import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:minesweeper/src/providers/cell_selector.dart';
import 'package:provider/provider.dart';

import '../game/cell/cell.dart';

class BoardGrid extends StatefulWidget {
  BoardGrid({Key key, this.side, this.mineCount}) : super(key: key);

  final int side;
  final int mineCount;

  @override
  State<StatefulWidget> createState() {
    return _BoardGridState();
  }
}

class _BoardGridState extends State<BoardGrid> {
  static final colors = <Color>[
    CupertinoColors.activeOrange.darkColor,
    CupertinoColors.systemBlue,
    CupertinoColors.activeGreen,
    CupertinoColors.destructiveRed,
  ];
//  Board _board;
//  final _selector = Provider.of<CellSelector>(context);

  @override
  void initState() {
    super.initState();
//    final selector = Provider.of<CellSelector>(context);
//    selector.makeBoard(width: widget.side, height: widget.side, mineCount: 5);
  }

  @override
  Widget build(BuildContext context) {
//    final selector = Provider.of<CellSelector>(context);
//    selector.makeBoard(width: widget.side, height: widget.side, mineCount: 5);
//    return Text('hmm');
//    _board = Board(widtsh: widget.side, height: widget.side)..placeMines(5);

    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.side * widget.side,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.side,
        ),
        itemBuilder: (context, index) {
//          return Text(index.toString());
          return _itemBuilder(context, index);
//        if (index >= widget.side * widget.side) return null;

//          return Text(index.toString());
        },
      ),
      height: MediaQuery.of(context).size.width,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final selector = Provider.of<CellSelector>(context);
    final x = index ~/ widget.side;
    final y = index % widget.side;
    final selected = selector.selectedX == x && selector.selectedY == y;
    final cell = selector.cell(x, y);
    final icon = _cellIcon(cell, x, y);
    Color color;
    if (cell.isCovered) {
      color = (index % 2 == 0)
          ? CupertinoColors.systemBlue.darkColor.withAlpha(250)
          : CupertinoColors.systemBlue.withAlpha(250);
    } else {
      color = (index % 2 == 0)
          ? CupertinoColors.white
          : CupertinoColors.extraLightBackgroundGray;
    }

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: selected
              ? Border.all(color: CupertinoColors.activeOrange, width: 4)
              : null,
        ),
        child: Center(
          child: _cellIcon(cell, x, y),
        ),
      ),
      onTap: () {
        if (selector.board.cell(x, y).isCovered) {
          if (selector.isSelectedAt(x, y)) {
            selector.find();
          } else {
            selector.selectCell(x, y);
          }
        } else {
          selector.unselectCell();
        }
      },
    );
  }

  Widget _cellIcon(Cell cell, int x, int y) {
    if (cell.isFlagged) {
      return Icon(
        Icons.flag,
        color: CupertinoColors.destructiveRed,
        size: 40,
      );
    }
    if (!cell.isCovered) {
      if (cell.hasMine) {
        return Icon(
          CupertinoIcons.clear_thick_circled,
          color: CupertinoColors.black,
          size: 40,
        );
      }

      if (cell.isBlank) {
        final selector = Provider.of<CellSelector>(context);
        final mineCount = selector.board.aroundMineCount(x, y);
        if (mineCount == 0) return null;
        return Text(
          mineCount.toString(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _countColor(mineCount),
          ),
        );
      }
    }

    return null;
  }

  Color _countColor(int count) {
    final index = count % colors.length;
    return colors[index];
  }
}
