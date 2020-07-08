import 'dart:math';

import 'package:flutter/cupertino.dart';

class CellPoint with ChangeNotifier {
  Point<int> _point;

  void point(Point<int> point) {
    _assertPointIsNotNegative(point);
    _point = point;
    notifyListeners();
  }

  void _assertPointIsNotNegative(Point<int> point) {
    assert(!point.x.isNegative);
    assert(!point.y.isNegative);
  }

  int get x => _point.x;

  int get y => _point.y;

  Point asPoint() => _point;
}
