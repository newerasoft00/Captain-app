import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportsbet/user%20view/Controller/profile_controller.dart';

class HomeController extends GetxController {
  var pageindex = 0.obs;

  RxBool noselectedMath = false.obs;
  final GetStorage box = GetStorage();

  void changePageIndex(int index) {
    pageindex.value = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    pageindex = 0.obs;
    ProfileController().onInit();
  }
}
