// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "QrcodeTitle": MessageLookupByLibrary.simpleMessage("扫描连接 WiFi"),
        "WiFiInformation": MessageLookupByLibrary.simpleMessage("WiFi 信息"),
        "WiFiPageNoRoot": MessageLookupByLibrary.simpleMessage(
            "本功能需要Root权限，如果没有Root请使用无Root功能。"),
        "WiFiPageOneCopy": MessageLookupByLibrary.simpleMessage("复制"),
        "WiFiPageOneCopySuss": MessageLookupByLibrary.simpleMessage("复制成功"),
        "WiFiPageOneQrcode": MessageLookupByLibrary.simpleMessage("二维码"),
        "WiFiPageTitleOne": MessageLookupByLibrary.simpleMessage("WiFi 密码"),
        "WiFiPageTitleTwo": MessageLookupByLibrary.simpleMessage("无 Root"),
        "WiFiPageTitleTwoQRCode":
            MessageLookupByLibrary.simpleMessage("选择WiFi二维码"),
        "appName": MessageLookupByLibrary.simpleMessage("WiFi Password"),
        "copyPsk": MessageLookupByLibrary.simpleMessage("复制WiFi密码"),
        "copySsid": MessageLookupByLibrary.simpleMessage("复制WiFi名称"),
        "copySsidAndPsk": MessageLookupByLibrary.simpleMessage("复制WiFi名称与密码"),
        "notFoundQrcode": MessageLookupByLibrary.simpleMessage("未找到WiFi信息"),
        "psk": MessageLookupByLibrary.simpleMessage("WiFi密码: "),
        "shiYong1": MessageLookupByLibrary.simpleMessage("使用说明："),
        "shiYong2":
            MessageLookupByLibrary.simpleMessage("点击下面按钮选择WiFi二维码图片即可。"),
        "shiYong3": MessageLookupByLibrary.simpleMessage("WiFi二维码："),
        "shiYong4": MessageLookupByLibrary.simpleMessage(
            "系统设置 - WLAN - 点击已经连接的WiFi - WLAN二维码。"),
        "ssid": MessageLookupByLibrary.simpleMessage("WiFi名称: ")
      };
}
