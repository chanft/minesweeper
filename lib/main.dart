import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minesweeper/src/providers/cell_point.dart';
import 'package:minesweeper/src/providers/game_timer.dart';
import 'package:provider/provider.dart';

import 'src/providers/cell_selector.dart';
import 'src/ui/index_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CellSelector>(
          create: (context) => CellSelector(),
        ),
        ChangeNotifierProvider<GameTimer>(
          create: (context) => GameTimer(),
        ),
        ChangeNotifierProvider<CellPoint>(
          create: (context) => CellPoint(),
        ),
      ],
      child: CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: IndexPage(),
      ),
    );
  }
}
