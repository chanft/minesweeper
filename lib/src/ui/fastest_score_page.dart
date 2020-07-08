import 'package:flutter/cupertino.dart';

import 'meta/license_page.dart';

class FastestScorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FastestScorePageState();
  }
}

class _FastestScorePageState extends State<FastestScorePage> {
  String _selectedKey = 'beginner';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('최단기록'),
            trailing: GestureDetector(
                child: Text(
                  '라이선스',
                  style: CupertinoTheme.of(context).textTheme.actionTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => LicensePage()),
                  );
                }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CupertinoSlidingSegmentedControl(
                children: {
                  'beginner': Text('초급'),
                  'intermediate': Text('중급'),
                  'expert': Text('고급'),
                },
                groupValue: _selectedKey,
                onValueChanged: (value) {
                  setState(() => _selectedKey = value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
}
