import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wifi/common/routers.dart';
import 'package:wifi/generated/l10n.dart';

void main() {
  // Admob
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AppOpenAd? appOpenAd;

  Future<void> loadAd() async {
    await AppOpenAd.load(
        adUnitId: "ca-app-pub-2998964302669273/8620878438",
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              print(ad);
              appOpenAd = ad;
            },
            onAdFailedToLoad: (error) {
              print(error);
            }
        ),
        orientation: AppOpenAd.orientationPortrait
    );
  }

  void showAd() {
    if (appOpenAd == null) {
      print("11");
      loadAd();
      return;
    }
    appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {

      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        print("Failed to load $error");
        appOpenAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        print("dismissed");
        appOpenAd = null;
        loadAd();
      }
    );
    appOpenAd!.show();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await loadAd();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: AutoSizeUtil.appBuilder,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      title: 'WI-FI',
        localizationsDelegates: [
          S.delegate,                                            //intl的delegate
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,  //支持的国际化语言
        // locale: Locale('zh', ''),                       //当前的语言
        localeListResolutionCallback: (locales, supportedLocales) {
          print('当前系统语言环境$locales');
          return;
        },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      routes: routers,
      initialRoute: 'home',
    );
  }
}