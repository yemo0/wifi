import 'package:wifi/view/home.dart';
import 'package:wifi/view/wifi_no_root.dart';
import 'package:wifi/view/wifi_view.dart';

final routers = {
  'home': (context) => Home(title: "WiFi Pass"),
  'wifi_no_root': (context) => WifiNoRoot(),
  'wifi_root': (context) => WiFiRoot(),
};