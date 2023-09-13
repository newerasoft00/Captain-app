import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Core/helper/shared_preference/shared_preference.dart';
import '../Model/ads/user_information.dart';

class ProfileController extends GetxController {
  RxBool isLightTheme = true.obs;
  Rx<User?> user = Rx<User?>(null);
  
  Future<void> fetchUserData(String userId) async {
    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("User Information")
          .doc('+966127537311')
          .get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        user.value = User.fromJson(userData);
      }
    } catch (e) {
      Get.snackbar('error', '$e.message');
    }
  }
@override
  void onInit()async {
   await fetchUserData(UserPreference.getUserid().toString());
    super.onInit();
  }
}
