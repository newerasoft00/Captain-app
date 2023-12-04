import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Vote/controller/best_goals_controller.dart';
import 'package:sportsbet/app/modules/Vote/controller/vote_controller.dart';


class VoteBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(VoteController());
    
  }
}

class VideoBinding extends Bindings {
  @override
  void dependencies() {
        Get.put(VideoController());

  }
}
