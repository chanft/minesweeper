import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons, showLicensePage;
import 'package:minesweeper/src/ui/cgame_page.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square),
            title: Text('초급'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all),
            title: Text('중급'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            title: Text('고급'),
          ),
        ],
      ),
      tabBuilder: (_, index) {
        if (index == 0) {
          return CGamePage(index);
//          return GamePage(index);
        } else {
          return CupertinoPageScaffold(
            child: Center(
              child: Text('미구현'),
            ),
          );
        }
      },
    );
  }
}
