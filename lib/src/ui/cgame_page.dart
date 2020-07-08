import 'package:flutter/cupertino.dart';
import 'package:minesweeper/src/game/board.dart';
import 'package:minesweeper/src/game/boards.dart';
import 'package:minesweeper/src/game/mine_generator.dart';
import 'package:minesweeper/src/preference/fastest_record.dart';
import 'package:minesweeper/src/ui/cell_button.dart';

import 'fastest_score_page.dart';

class CGamePage extends StatefulWidget {
  final int _index;

  CGamePage(this._index);

  int get side {
    final sides = [7, 11, 15];
    return sides[_index];
  }

  @override
  State<StatefulWidget> createState() {
    return _CGamePageState();
  }
}

class _CGamePageState extends State<CGamePage> {
  Board _board;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _initBoard();
  }

  @override
  Widget build(BuildContext context) {
    if (_board == null) return CupertinoActivityIndicator();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: GestureDetector(
          child: Text(
            '최단기록',
            style: CupertinoTheme.of(context).textTheme.actionTextStyle,
          ),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => FastestScorePage()),
            );
          },
        ),
        leading: GestureDetector(
          child: Icon(CupertinoIcons.refresh),
          onTap: () {
//            selector.makeBoard(width: side, height: side, mineCount: side);
          },
        ),
        middle: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Icon(CupertinoIcons.flag),
              ),
              TextSpan(text: '${_board.remainingMineCount}'),
            ],
          ),
        ),
      ),
      child: gridboard,
//      child: Center(
//        child: Text(_board.toJson().toString()),
//      ),
    );
  }

  Future<void> _initBoard() async {
    final records = await FastestRecord.instance();
    Board record = records.getBeginnerRecord();
    if (record == null) {
      record = Boards.newBeginnerBoard();
      MineGenerator(record).generateMines(widget.side);
    }

    setState(() {
      _board = record;
    });
  }

  get gridboard {
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.side * widget.side,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.side,
        ),
        itemBuilder: (context, index) {
          final x = index % _board.width;
          final y = index ~/ _board.width;
//          return Text(index.toString());
          return CellButton(
            cell: _board.cell(x, y),
            index: index,
            onTap: () {},
          );
        },
      ),
      height: MediaQuery.of(context).size.width,
    );
  }
}
