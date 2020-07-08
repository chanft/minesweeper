import 'dart:convert';

import 'package:minesweeper/src/game/board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FastestRecord {
  SharedPreferences _pref;

  static Future<FastestRecord> instance() async {
    final instance = FastestRecord._();
    await instance._initPreference();
    return instance;
  }

  FastestRecord._();

  _initPreference() async {
    _pref = await SharedPreferences.getInstance();
  }

  // TODO: return record class, contains board and timer
  Board getBeginnerRecord() => _getBoard('beginner_record');
  Board getIntermediateRecord() => _getBoard('intermediate_record');
  Board getExpertRecord() => _getBoard('expert_record');

  Board _getBoard(String key) {
    final record = _pref.getString(key);
    if (record == null) return null;

    return Board.fromJson(json.decode(record));
  }

  void setBeginnerRecord(Board board) => _setRecord('beginner_record', board);
  void setIntermediateRecord(Board board) =>
      _setRecord('intermediate_record', board);
  void setExpertRecord(Board board) => _setRecord('expert_record', board);

  void _setRecord(String key, Board board) {
    final record = json.encode(board.toJson());
    _pref.setString(key, record);
  }
}
