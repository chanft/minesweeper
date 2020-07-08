import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/cell_selector.dart';

class ActionField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selector = Provider.of<CellSelector>(context);

    return CupertinoSegmentedControl(
      padding: EdgeInsets.only(top: 20),
      children: {
        'flag': Icon(
          CupertinoIcons.flag,
          size: 64,
          color: CupertinoColors.systemRed,
        ),
        'find': Icon(CupertinoIcons.search, size: 64),
      },
      onValueChanged: (v) {
        if (!selector.isSelected) return;
        print(v);
        switch (v) {
          case 'flag':
            return selector.flag();
          case 'find':
            return selector.find();
        }
      },
    );
  }
}
