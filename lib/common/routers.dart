import 'package:wifi/pages/home.dart';
import 'package:wifi/pages/loading.dart';
import 'package:wifi/pages/wifi_no_root.dart';
import 'package:wifi/pages/wifi_root.dart';

final routers = {
  'home': (context) => Home(title: "My WiFi Password"),
  'loading': (context) => Loading(),
  'wifi_no_root': (context) => WifiNoRoot(),
  'wifi_root': (context) => WiFiRoot(),
};