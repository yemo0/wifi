import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi/generated/l10n.dart';
import 'package:wifi/pages/wifi_no_root.dart';
import 'package:wifi/pages/wifi_root.dart';

class Home extends StatefulWidget {
  const Home({Key ? key, required this.title}) : super (key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    
    final _cTabs = <Tab> [
      Tab(text: S.of(context).WiFiPageTitleOne),
      Tab(text: S.of(context).WiFiPageTitleTwo)
    ];

    final _cTabBarView = <Widget> [
      const WiFiRoot(),
      const WifiNoRoot(),
    ];
    
    return DefaultTabController(
      length: _cTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: _cTabs
          ),
        ),
        body: TabBarView(
          children: _cTabBarView,
        ),
      ),
    );
  }
}