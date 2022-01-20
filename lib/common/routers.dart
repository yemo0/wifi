import 'package:wifi/pages/home.dart';
import 'package:wifi/pages/loding.dart';
import 'package:wifi/pages/wifi_no_root.dart';
import 'package:wifi/pages/wifi_root.dart';

final routers = {
  'home': (context) => Home(title: "text"),
  'loading': (context) => Loading(),
  'wifi_no_root': (context) => WifiNoRoot(),
  'wifi_root': (context) => WiFiRoot(),
};