import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:root/root.dart';
import 'package:wifi/generated/l10n.dart';
import 'package:xml/xml.dart';

class WiFiRoot extends StatefulWidget {
  const WiFiRoot({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WiFiRootState();
}

class _WiFiRootState extends State<WiFiRoot> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
  bool _rootStatus = false;
  Future<void> getRoot() async {
    bool rootStatus = await Root.isRooted() ?? false;
    _rootStatus = rootStatus;
  }
  List wifiList = [];

  // DeviceInfo 获取设备信息
  Future<int> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var release = androidInfo.version.release.split('.');
    return int.parse(release[0]);
  }

  // 获取wifi密码安卓8以下
  Future<void> getWiFi8() async {
    String res = await Root.exec(cmd: "cat /data/misc/wifi/wpa_supplicant.conf") ?? "";
    var resList = res.split('\n');
    for (var i = 0; true; i++) {
      if (i == resList.length) {
        break;
      }
      if (resList[i] == "network={") {
        Map m = {};
        for (;true;i++) {
          if (resList[i].trim().startsWith("ssid")) {
            print("找到ssid了");
            m["ssid"] = resList[i].split('=')[1].replaceAll("\"", "");
          } else if (resList[i].trim().startsWith("psk")){
            print("找到psk了");
            m['psk'] = resList[i].toString().split("=")[1].replaceAll("\"", "");
          } else if (resList[i] == "}") {
            wifiList.add(m);
            break;
          }
        }
      }
    }
    print(wifiList);
  }

  // 获取wifi密码安卓8-11
  Future<void> getWiFi9() async {
    String res = await Root.exec(cmd: "cat /data/misc/wifi/WifiConfigStore.xml") ?? "";
    final document = XmlDocument.parse(res);
    var elements = document.findAllElements("WifiConfiguration").toList();
    for (int i = 0; i < elements.length; i++) {
      // 去掉无密码的
      if (!elements[i].findElements('string').first.text.endsWith("NONE")) {
        Map m = {};
        m["ssid"] = elements[i].findElements("string").toList()[1].text.replaceAll("\"", "");
        m['psk'] = elements[i].findElements("string").toList()[2].text.replaceAll("\"", "");
        wifiList.add(m);
      };
    }
  }

  // 获取wifi密码安卓11
  Future<void> getWiFi11() async {
    String res = await Root.exec(cmd: "cat /data/misc/apexdata/com.android.wifi/WifiConfigStore.xml") ?? "";
    final document = XmlDocument.parse(res);
    var elements = document.findAllElements("WifiConfiguration").toList();
    // for (var element in elements) {
    //   print(element.findElements("string").toList()[1].text);
    //   print(element.findElements("string").toList()[2].text);
    // }
    for (int i = 0; i < elements.length; i++) {
      // 去掉无密码的
      if (!elements[i].findElements('string').first.text.endsWith("NONE")) {
        Map m = {};
        m["ssid"] = elements[i].findElements("string").toList()[1].text.replaceAll("\"", "");
        m['psk'] = elements[i].findElements("string").toList()[2].text.replaceAll("\"", "");
        wifiList.add(m);
      };
    }
  }

  @override
  void initState() {
    getRoot();
    if (!_rootStatus) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!_rootStatus) {
          getRoot();
          print("无root权限！");
        } else {
          print("已获取root权限！");
          timer.cancel();
          setState(() {});
        }
      });
    }

    // 判断安卓版本
    getDeviceInfo().then((value) {
      if (value < 8) {
        print("安卓8以下");
        getWiFi8();
      } else if (value < 11) {
        print("安卓8-11");
        getWiFi9();
      } else {
        print("安卓11以上");
        getWiFi11();
      }
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
