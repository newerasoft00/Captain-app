import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';

import '../Model/ads/user_information.dart';

class ProfileController extends GetxController {
  RxBool isLightTheme = true.obs;
  final userPhoneNumber = '+201004002804';
  final firestoreInstance = FirebaseFirestore.instance;
  RxList<User> user = RxList<User>();
  User? userinformation;

  Future<void> getUserData() async {
    try {
      final userDocument = await firestoreInstance
          .collection('User Information')
          .doc(UserPreference.getUserid())
          .get();

      if (userDocument.exists) {
        final userData = userDocument.data() as Map<String, dynamic>;
        // Now you can access user properties like email, name, etc.
        
        User userinfo = User(
          email: userData['email'],
          phoneNumber: userData['phoneNumber'],
          
          name: userData['name'],
          password: userData['password'],
          uid: userData['uid'],
        );
        userinformation = User.fromJson(userData);
        user.add(userinfo);

        // Do something with the user data
      }
    } catch (e) {
      print('Error getting user document: $e');
      // Handle errors appropriately
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  @override
  void onClose() {
    user.clear();
    super.onClose();
  }
}
