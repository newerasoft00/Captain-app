import 'package:get/get.dart';
import '../ads/ad_controller.dart';
import 'network_controller.dart';

class DependencyInjection {
  
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
    Get.put<AdvertisersController>(AdvertisersController(),permanent:true);
  }
}