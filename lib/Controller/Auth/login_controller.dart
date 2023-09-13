import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Controller/profile_Controller.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth credentials = FirebaseAuth.instance;
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;

  RxBool securePassword = true.obs;

  final ProfileController c = Get.put(ProfileController());
  // Firebase Login
  signinwithemail() async {
    try {
      final userCredential = await credentials
          .signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      )
          .then((value) {
        UserPreference.setUserId(phoneNumber.value);
      });

      final user = userCredential.user;
      if (user != null) {
        // Get the existing instance of ProfileController
        await c.fetchUserData('+966127537311');
        final userData = c.user.value;
        if (userData != null) {
          // Save user data in SharedPreferences
          await UserPreference.setUserId(userData.phoneNumber);
          await UserPreference.setIsLoggedIn(true);

          // Navigate to the ProfileScreen
          Get.to(() => const HomeScreen());
        }

        Get.snackbar(
          'Success',
          'Logged in successfully',
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'Email not found',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'password is incorrect',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        '$e',
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
