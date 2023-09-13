/* import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  InterstitialAd? _interstitialAd;

  void loadInterstitialAd() {
    String interstitialAdId =
        Platform.isAndroid ? "ca-app-pub-1264835814900584/3727468693" : "ca-app-pub-1264835814900584/4295719999";

    InterstitialAd.load(
        adUnitId: interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
            showInterstitial();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  var openAdOpened = false;
  void loadOpenAppAd() {
    if (openAdOpened) return;
    openAdOpened = true;
    AppOpenAd.load(
      adUnitId: Platform.isAndroid ? "ca-app-pub-1264835814900584/8788223685" : 'ca-app-pub-1264835814900584/1095729630',
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }

  void showInterstitial() {
    _interstitialAd?.show();
  }

  void disposeAds() {
    _interstitialAd?.dispose();
  }
}
 */