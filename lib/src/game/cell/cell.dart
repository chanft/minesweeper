import 'package:json_annotation/json_annotation.dart';
import 'package:minesweeper/src/game/cell/cover.dart';
import 'package:minesweeper/src/game/cell/item.dart';

part 'cell.g.dart';

class Cell {
  Item _item;
  Cover _cover;

  Cell({Item item = Item.none, Cover cover = Cover.unflagged})
      : this._item = item,
        this._cover = cover;

  Cell copyWith({Item item, Cover cover}) =>
      Cell(item: item ?? this._item, cover: cover ?? this._cover);

  Map<String, dynamic> toJson() =>
      _CellJson(item: _item, cover: _cover).toJson();

  factory Cell.fromJson(Map<String, dynamic> json) =>
      _CellJson.fromJson(json).toCell();

  void flag() {
    if (isCovered) {
      _cover = Cover.flagged;
    }
  }

  void unflag() {
    if (isFlagged) {
      _cover = Cover.unflagged;
    }
  }

  void uncover() => _cover = Cover.uncovered;

  bool get isFlagged => _cover == Cover.flagged;
  bool get isUncovered => _cover == Cover.uncovered;
  bool get isCovered => !isUncovered;

  void setMine() => _item = Item.mine;

  bool get hasMine => _item == Item.mine;
  bool get isBlank => _item == Item.none;
}

@JsonSerializable()
class _CellJson {
  _CellJson({this.item, this.cover});

  final Item item;
  final Cover cover;

  factory _CellJson.fromJson(Map<String, dynamic> json) =>
      _$_CellJsonFromJson(json);

  Map<String, dynamic> toJson() => _$_CellJsonToJson(this);

  Cell toCell() => Cell(item: item, cover: cover);
}
