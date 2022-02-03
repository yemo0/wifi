// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `WiFi Password`
  String get appName {
    return Intl.message(
      'WiFi Password',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `WiFi View`
  String get WiFiPageTitleOne {
    return Intl.message(
      'WiFi View',
      name: 'WiFiPageTitleOne',
      desc: '',
      args: [],
    );
  }

  /// `No Root`
  String get WiFiPageTitleTwo {
    return Intl.message(
      'No Root',
      name: 'WiFiPageTitleTwo',
      desc: '',
      args: [],
    );
  }

  /// `QR code`
  String get WiFiPageOneQrcode {
    return Intl.message(
      'QR code',
      name: 'WiFiPageOneQrcode',
      desc: '',
      args: [],
    );
  }

  /// `copy`
  String get WiFiPageOneCopy {
    return Intl.message(
      'copy',
      name: 'WiFiPageOneCopy',
      desc: '',
      args: [],
    );
  }

  /// `Wi-Fi QR code`
  String get QrcodeTitle {
    return Intl.message(
      'Wi-Fi QR code',
      name: 'QrcodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Copy successful`
  String get WiFiPageOneCopySuss {
    return Intl.message(
      'Copy successful',
      name: 'WiFiPageOneCopySuss',
      desc: '',
      args: [],
    );
  }

  /// `don't have root access, Please use no root`
  String get WiFiPageNoRoot {
    return Intl.message(
      'don\'t have root access, Please use no root',
      name: 'WiFiPageNoRoot',
      desc: '',
      args: [],
    );
  }

  /// `Select QR code`
  String get WiFiPageTitleTwoQRCode {
    return Intl.message(
      'Select QR code',
      name: 'WiFiPageTitleTwoQRCode',
      desc: '',
      args: [],
    );
  }

  /// `WiFi information`
  String get WiFiInformation {
    return Intl.message(
      'WiFi information',
      name: 'WiFiInformation',
      desc: '',
      args: [],
    );
  }

  /// `ssid: `
  String get ssid {
    return Intl.message(
      'ssid: ',
      name: 'ssid',
      desc: '',
      args: [],
    );
  }

  /// `pass: `
  String get psk {
    return Intl.message(
      'pass: ',
      name: 'psk',
      desc: '',
      args: [],
    );
  }

  /// `Copy ssid`
  String get copySsid {
    return Intl.message(
      'Copy ssid',
      name: 'copySsid',
      desc: '',
      args: [],
    );
  }

  /// `Copy pass`
  String get copyPsk {
    return Intl.message(
      'Copy pass',
      name: 'copyPsk',
      desc: '',
      args: [],
    );
  }

  /// `Copy ssid & pass`
  String get copySsidAndPsk {
    return Intl.message(
      'Copy ssid & pass',
      name: 'copySsidAndPsk',
      desc: '',
      args: [],
    );
  }

  /// `QR code not found`
  String get notFoundQrcode {
    return Intl.message(
      'QR code not found',
      name: 'notFoundQrcode',
      desc: '',
      args: [],
    );
  }

  /// `Instructions for use：`
  String get shiYong1 {
    return Intl.message(
      'Instructions for use：',
      name: 'shiYong1',
      desc: '',
      args: [],
    );
  }

  /// `Just click the button below to select the WiFi QR code image。`
  String get shiYong2 {
    return Intl.message(
      'Just click the button below to select the WiFi QR code image。',
      name: 'shiYong2',
      desc: '',
      args: [],
    );
  }

  /// `WiFi QR Code：`
  String get shiYong3 {
    return Intl.message(
      'WiFi QR Code：',
      name: 'shiYong3',
      desc: '',
      args: [],
    );
  }

  /// `System settings - WLAN - Click on the connected WiFi - WLAN QR code。`
  String get shiYong4 {
    return Intl.message(
      'System settings - WLAN - Click on the connected WiFi - WLAN QR code。',
      name: 'shiYong4',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
