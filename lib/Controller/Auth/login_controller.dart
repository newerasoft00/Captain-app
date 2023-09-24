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
  RxBool presssignin = false.obs;
  RxBool securePassword = true.obs;

  toggleSignup() {
    presssignin.toggle();
  }

  // Firebase Login
  signinwithemail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '${phoneNumber.value}@gmail.com',
        password: password.value,
      );

      await UserPreference.setUserId(phoneNumber.value.toString());
      if (remmemberme.value == true) {
        await UserPreference.setIsLoggedIn(true);
      } else {
        await UserPreference.setIsLoggedIn(false);
      }
      Get.offAll(() => const HomeScreen());
      presssignin.value = false;
    } catch (e) {
      // Display the exception in a snackbar
      Get.snackbar(
        'error',
        "error while sign in $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      );
    }
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
