import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi/generated/l10n.dart';

class Share extends StatefulWidget {
  const Share({Key ? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).WiFiPageOneShare),
      ),
    );
  }
}