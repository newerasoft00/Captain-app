import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';

import '../../View/Screens/Auth/Login/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth credentials = FirebaseAuth.instance;
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;
  RxBool remmemberme = false.obs;

  RxBool securePassword = true.obs;
  // Firebase Login
  signinwithemail() async {
    credentials
        .signInWithEmailAndPassword(
      email: email.value,
      password: password.value,
    )
        .then((value) async {
      await UserPreference.setUserId(phoneNumber.value.toString());
      (remmemberme.value == true)
          ? await UserPreference.setIsLoggedIn(true)
          : await UserPreference.setIsLoggedIn(false);
      Get.offAll(() => const HomeScreen());
    });
  }

  void signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      UserPreference.setIsLoggedIn(false);
      UserPreference.setUserId('');
      Get.snackbar(
        'Success',
        'Logged out successfully',
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      );
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while signing out: $e',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void onClose() {
    phoneNumber = ''.obs;
    password = ''.obs;
    email = ''.obs;
    super.onClose();
  }
}
