import 'package:get/get.dart';
import 'package:captain/app/modules/user%20feedback/controller/feedback_controller.dart';

class FeedBackBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FeedbackController());
  }
}
