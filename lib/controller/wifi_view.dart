import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:root/root.dart';
import 'package:xml/xml.dart';

class WiFiView {
  //wifi数据
  List wifiList = [];

  // isRoot
  // bool _rootStatus = false;
  Future<bool> getRoot() async {
    bool rootStatus = await Root.isRooted() ?? false;
    // _rootStatus = rootStatus;
    return rootStatus;
  }




  // DeviceInfo 获取设备信息
  Future<int> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var release = androidInfo.version.release.split('.');
    return int.parse(release[0]);
  }

  //  获取wifi密码
  Future<List> getWifiView(int releaseNum) async {
    if (releaseNum < 8) {
      getWiFi8();
    } else if (releaseNum < 11) {
      getWiFi9();
    } else {
      getWiFi11();
    }
    return wifiList;
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
}