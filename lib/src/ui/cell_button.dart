import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/src/game/cell/board_cell.dart';

class CellButton extends StatelessWidget {
  static final colors = <Color>[
    CupertinoColors.activeOrange.darkColor,
    CupertinoColors.systemBlue,
    CupertinoColors.activeGreen,
    CupertinoColors.destructiveRed,
  ];

  CellButton({this.cell, this.index, this.onTap});

  final BoardCell cell;
  final int index;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var selected = false;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: selected
              ? Border.all(color: CupertinoColors.activeOrange, width: 4)
              : null,
        ),
        child: Center(
          child: _icon,
        ),
      ),
      onTap: onTap,
    );
  }

  Color _countColor(int count) {
    final index = count % colors.length;
    return colors[index];
  }

  Widget get _icon {
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
        final mineCount = cell.aroundMineCount;
        if (mineCount == 0) return null;
        return Text(
          mineCount.toString(),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: _countColor(mineCount),
          ),
        );
      }
    }

    return null;
  }

  Color get _backgroundColor {
    if (cell.isCovered) {
      return (index % 2 == 0)
          ? CupertinoColors.systemBlue.darkColor.withAlpha(250)
          : CupertinoColors.systemBlue.withAlpha(250);
    } else {
      return (index % 2 == 0)
          ? CupertinoColors.white
          : CupertinoColors.extraLightBackgroundGray;
    }
  }
}
