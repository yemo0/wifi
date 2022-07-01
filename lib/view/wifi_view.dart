import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wifi/controller/wifi_view.dart';
import 'package:wifi/generated/l10n.dart';

class WiFiRoot extends StatefulWidget {
  const WiFiRoot({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WiFiRootState();
}

class _WiFiRootState extends State<WiFiRoot> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List wifiList = [];
  bool _rootStatus = false;

  @override
  initState()  {
    WiFiView().getRoot().then((value) => {
      _rootStatus = value
    });
    if (!_rootStatus) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!_rootStatus) {
          WiFiView().getRoot().then((value) => {
            _rootStatus = value
          });
          print("无root权限！");
        } else {
          print("已获取root权限！");
          timer.cancel();
          setState(() {});
        }
      });
    }

    WiFiView().getDeviceInfo().then((value) => {
      WiFiView().getWifiView(value).then((value) => {
        wifiList = value
      })
    });
    super.initState();
  }

  showQrcode(context, i) {
    var psk = wifiList[i]['psk'] ??= "";
    var ssid = wifiList[i]['ssid'] ??= "";
    showDialog(
        context: context,
        // barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(S.of(context).QrcodeTitle),
            content: Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              child: QrImage(
                data: 'WIFI:S:'+ ssid + ';T:WPA;P:' + psk +';H:true;;',
                version: QrVersions.auto,
                size: 200,
                gapless: false,
              ),
            ),
          );
        }
    );
  }

  copyPassword(context, i) {
    Clipboard.setData(ClipboardData(text: wifiList[i]['psk'] ??= ""));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).WiFiPageOneCopySuss),
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget _buildRow(int i) {
      return Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) => showQrcode(context, i),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.qr_code,
              label: S.of(context).WiFiPageOneQrcode,
            ),
            SlidableAction(
              onPressed: (context) => copyPassword(context, i),
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.content_copy,
              label: S.of(context).WiFiPageOneCopy,
            ),
          ],
        ),
        child: ListTile(
          title: Text('${wifiList[i]['ssid']}'),
          subtitle: Text('${wifiList[i]['psk'] ??= ""}'),
        ),
      );
    }

    Widget _isRoot() {
      if (_rootStatus) {
        return ListView.builder(
            itemCount: wifiList.length,
            itemBuilder: (BuildContext context, int i) {
              return _buildRow(i);
            }
        );
      }
      return Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Text(S.of(context).WiFiPageNoRoot),
        ),
      );
    }

    // TODO: implement build
    return _isRoot();
  }
}
