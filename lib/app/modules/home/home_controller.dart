import 'package:get/get.dart';
import '../profile/controller/profile_controller.dart';

class HomeController extends GetxController {
  var pageindex = 0.obs;

  RxBool noselectedMath = false.obs;

  void changePageIndex(int index) {
    pageindex.value = index;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    pageindex = 0.obs;
    ProfileController().onInit();
  }
}
