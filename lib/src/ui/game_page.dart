import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:minesweeper/src/providers/cell_selector.dart';
import 'package:minesweeper/src/ui/fastest_score_page.dart';
import 'package:provider/provider.dart';

import 'file:///C:/Users/nnlei/AndroidStudioProjects/minesweeper/lib/src/ui/meta/license_page.dart';

import 'action_field.dart';
import 'board_grid.dart';

class GamePage extends StatelessWidget {
  GamePage(this._index) {
//    Timer.periodic(Duration(seconds: 1), (timer) => _passedSeconds++);
  }

  final int _index;
//  final int _side;
//  final int _mineCount;
  final _memoizer = AsyncMemoizer();

  int get side {
    switch (_index) {
      case 0:
        return 7;
      case 1:
        return 11;
      case 2:
        return 15;
      default:
        throw Error();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selector = Provider.of<CellSelector>(context);
//    final timer = Provider.of<GameTimer>(context);
//    print('win ${selector.board.isWon}');
//    print('def ${selector.board.isDefeated}');

    _memoizer.runOnce(
      () => selector.makeBoard(width: side, height: side, mineCount: side),
    );
//    if (!timer.isActive && selector.board.uncoveredCellCount > 0) {
//      timer.start();
//    }

//    NavigationToolbar()
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: GestureDetector(
          child: Text(
            '최단기록',
            style: CupertinoTheme.of(context).textTheme.actionTextStyle,
          ),
          onTap: () {
            _showEllipsis(context);
          },
        ),
        leading: GestureDetector(
          child: Icon(CupertinoIcons.refresh),
          onTap: () {
            selector.makeBoard(width: side, height: side, mineCount: side);
//            timer.reset();
          },
        ),
        middle: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Icon(CupertinoIcons.flag),
              ),
              TextSpan(text: '${selector.board.remainingMineCount}'),
//              WidgetSpan(
//                child: Padding(
//                  padding: EdgeInsets.only(left: 24, right: 4),
//                  child: Icon(CupertinoIcons.clock),
//                ),
//              ),
//              TextSpan(text: '${timer.seconds}'),
            ],
          ),
        ),
      ),
      child: SafeArea(
//            child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BoardGrid(
              side: side,
              mineCount: side,
            ),
            Opacity(
              child: ActionField(),
              opacity: selector.isSelected ? 1 : 0,
            ),
          ],
        ),
      ),
    );
  }

  void _showEllipsis(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        message: Text('초보 레벨에서 최단 기록은 140초입니다.'),
        actions: <Widget>[
          CupertinoButton(
            child: Text('라이선스'),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => LicensePage()),
              );
            },
          ),
//          Icon(CupertinoIcons.),
          CupertinoButton(
            child: Text('score'),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => FastestScorePage()),
              );
            },
          ),
          CupertinoButton.filled(
            child: Text('test'),
            onPressed: () {
              showCupertinoDialog(
                context: context,
//                useRootNavigator: true,
                builder: (_) => CupertinoAlertDialog(
                  title: Text('지릐를 모두 찾았습니다.'),
                  content: Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 40),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.timer,
                            color: CupertinoColors.black,
                            size: 40,
                          ),
                        ),
                        TextSpan(text: '343'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    CupertinoButton(
                      child: Text('다시 플레이하기'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          CupertinoButton.filled(
            child: Text('test2'),
            onPressed: () {
              showCupertinoDialog(
                context: context,
//                useRootNavigator: true,
                builder: (_) => CupertinoAlertDialog(
                  title: Text('지릐를 찾았습니다.'),
                  content: Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 40),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.timer,
                            color: CupertinoColors.black,
                            size: 40,
                          ),
                        ),
                        TextSpan(text: '000'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    CupertinoButton(
                      child: Text('다시 플레이하기'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
