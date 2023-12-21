import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sportsbet/app/modules/ads/ad_manager.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final AdSize adSize = AdSize.banner;
  late BannerAd myBanner;

  @override
  void initState() {
    _createBanner();
    super.initState();
  }
  _createBanner() {
    myBanner = AdMobHelper.getBannerAd();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adSize.width.toDouble(),
      height: adSize.height.toDouble(),
      child: AdWidget(
        ad: myBanner,
      ),
    );
  }
}
