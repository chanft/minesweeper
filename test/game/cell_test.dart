import 'package:minesweeper/src/game/cell/cover.dart';
import 'package:minesweeper/src/game/cell/item.dart';
import 'package:test/test.dart';

import 'file:///C:/Users/nnlei/AndroidStudioProjects/minesweeper/lib/src/game/cell/cell.dart';

void main() {
  test('default state is not flagged and covered', () {
    final cell = Cell();
    expect(cell.isFlagged, false);
    expect(cell.isCovered, true);
  });

  group('flags', () {
    Cell cell;
    test('.flag()', () {
      cell = Cell()..flag();
      expect(cell.isFlagged, true);
    });

    test('.unflag()', () {
      cell.unflag();
      expect(cell.isFlagged, false);
    });
  });

  test('.uncover() make flag to false', () {
    final cell = Cell()
      ..flag()
      ..uncover();
    expect(cell.isFlagged, false);
  });

  test('.uncover()', () {
    final cell = Cell()..uncover();
    expect(cell.isCovered, false);
  });

  test('json', () {
    final cell = Cell(item: Item.mine, cover: Cover.uncovered);
    print(cell.toJson());
//    final c2 =
//        Cell.fromJson(json.decode('{"item": "mine", "cover": "uncovered"}'));
//    print(c2.toJson());
////    Item.values.singleWhere((element) => element.toString())
//    print(Item.mine.index);
  });
}
