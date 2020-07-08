import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info/package_info.dart';

class LicensePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LicensePageState();
  }
}

class _LicensePageState extends State<LicensePage> {
  PackageInfo _packageInfo;
  final _licenses = <Widget>[];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Localizations.override(
        context: context,
        locale: Locale('en', 'US'),
        child: DefaultTextStyle(
          style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.inactiveGray.darkElevatedColor),
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text('License'),
              ),
//          SliverList(
//            delegate: SliverChildBuilderDelegate((context, index) {
//              if (index == 0)
//                return Text(
//                  _packageInfo?.appName ?? '',
//                  style: TextStyle(fontSize: 32, color: CupertinoColors.black),
//                  textAlign: TextAlign.center,
//                );
//              return null;
//            }),
//          ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
//              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    children: <Widget>[
                      SizedBox(height: 16),
                      Text(
                        _packageInfo?.appName ?? '',
                        style: TextStyle(
                            fontSize: 32, color: CupertinoColors.black),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _packageInfo?.version ?? '',
                        style: TextStyle(color: CupertinoColors.black),
                        textAlign: TextAlign.center,
                      ),
//                SizedBox(height: 24),
                      ..._licenses,
                      if (!_loaded)
                        CupertinoActivityIndicator(),
                    ],
                  ),
                ),
              ),
//          SliverToBoxAdapter(
//            child: Text(
//              _packageInfo?.appName ?? '',
//              style: TextStyle(fontSize: 32, color: CupertinoColors.black),
//              textAlign: TextAlign.center,
//            ),
//          ),
//          Row(children: <Widget>[Text('s')],),
//          SafeArea(
//            child: Text('d'),
//          ),

//          SliverList(
//            delegate: SliverChildBuilderDelegate(),
//          ),
//          Localizations.override(
//            context: context,
//            locale: Locale('en', 'US'),
//            child: DefaultTextStyle(
//              style: TextStyle(
//                  fontSize: 16,
//                  color: CupertinoColors.inactiveGray.darkElevatedColor),
//              child: ListView(
//                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                children: <Widget>[
//                  Text(
//                    _packageInfo?.appName ?? '',
//                    style:
//                        TextStyle(fontSize: 32, color: CupertinoColors.black),
//                    textAlign: TextAlign.center,
//                  ),
//                  Text(
//                    _packageInfo?.version ?? '',
//                    style: TextStyle(color: CupertinoColors.black),
//                    textAlign: TextAlign.center,
//                  ),
//                  SizedBox(height: 24),
//                  ..._licenses,
//                  if (!_loaded) CupertinoActivityIndicator(),
//                ],
//              ),
//            ),
//          ),
            ],
          ),
        ),
      ),
    );
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('License'),
      ),
      child: Localizations.override(
        context: context,
        locale: Locale('en', 'US'),
        child: SafeArea(
          bottom: false,
          child: CupertinoScrollbar(
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.inactiveGray.darkElevatedColor),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                children: <Widget>[
                  Text(
                    _packageInfo?.appName ?? '',
                    style:
                        TextStyle(fontSize: 32, color: CupertinoColors.black),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _packageInfo?.version ?? '',
                    style: TextStyle(color: CupertinoColors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  ..._licenses,
                  if (!_loaded) CupertinoActivityIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _init() async {
    await _initPackageInfo();
    await _initLicenses();
    setState(() {
      _loaded = true;
    });
  }

  Future<void> _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  Future<void> _initLicenses() async {
    await for (final license in LicenseRegistry.licenses) {
      final paragraphs = await SchedulerBinding.instance.scheduleTask(
        license.paragraphs.toList,
        Priority.animation,
        debugLabel: 'License',
      );
      setState(() {
        _licenses.add(SizedBox(height: 64));
        _licenses
          ..add(Text(''))
          ..add(Container(
            child: Text(
              license.packages.join(', '),
              style: CupertinoTheme.of(context).textTheme.actionTextStyle,
              textAlign: TextAlign.center,
            ),
          ));
        for (final paragraph in paragraphs) {
          if (paragraph.indent == LicenseParagraph.centeredIndent) {
            _licenses.add(
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  paragraph.text,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            _licenses.add(
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 8,
                  start: 16.0 * paragraph.indent,
                ),
                child: Text(paragraph.text),
              ),
            );
          }
        }
      });
    }
  }
}
