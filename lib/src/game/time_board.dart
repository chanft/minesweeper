import 'dart:math';

import 'board.dart';

class TimeBoard extends Board {
  int _second = 0;

  set second(int sec) {
    assert(!sec.isNegative);
    _second = min(sec, 999);
  }

  int get second => _second;
}
