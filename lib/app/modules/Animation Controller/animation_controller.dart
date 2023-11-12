import 'package:get/get.dart';

class MyAnimationController extends GetxController {
  final RxDouble bannerHeight = 100.0.obs;
  final RxBool isBannerVisible = true.obs;
  final RxBool isShadowVisible = false.obs; // Duration for the banner animation
  final Duration bannerDuration = const Duration(milliseconds: 500);

  void startBannerAnimation() {
    isBannerVisible.value = true;
    bannerHeight.value = Get.height * 0.06;
    isShadowVisible.value = true;
    Future.delayed(bannerDuration, () {
      isBannerVisible.value = false;
      isShadowVisible.value = false;
      bannerHeight.value = 0.0;
    });
  }

  @override
  void onInit() {
    super.onInit();
    startBannerAnimation();
  }

  @override
  void onReady() {
    super.onReady();
    startBannerAnimation();
  }
}
