import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/Core/helper/log_printer.dart';

class AdMobHelper {
  static String get bannerId => 'ca-app-pub-3940256099942544/6300978111';

  static initialization() {
    MobileAds.instance.initialize();
  }

  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            logError('add loaded');
          },
          onAdFailedToLoad: (ad, error) {
            logError('Ad Failed $error');
          },
          onAdOpened: (ad) {
            logError('Ad Opend');
          },
        ),
        request: const AdRequest());
    return bAd;
  }
}
