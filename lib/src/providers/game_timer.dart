import 'dart:async';

import 'package:flutter/cupertino.dart';

class GameTimer with ChangeNotifier {
  int _passedSeconds = 0;
  Timer _timer;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _increaseSeconds());
  }

  void _increaseSeconds() {
    _passedSeconds++;
    notifyListeners();
  }

  int get seconds => _passedSeconds;

  void reset() {
    _timer?.cancel();
    _timer = null;
    _passedSeconds = 0;
    notifyListeners();
  }

  bool get isActive => _timer != null;
}
