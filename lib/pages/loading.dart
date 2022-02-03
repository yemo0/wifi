
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Loading extends StatefulWidget {
  const Loading({Key ? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  AppOpenAd? appOpenAd;

  Future<void> loadAd() async {
    await AppOpenAd.load(
      adUnitId: "ca-app-pub-3940256099942544/3419835294",
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print(ad);
          appOpenAd = ad;
          appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {
          print(error);
        }
      ),
      orientation: AppOpenAd.orientationPortrait
    );
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await loadAd();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text("ok"),
      )
    );
  }
}
