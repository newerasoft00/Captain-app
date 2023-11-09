import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/Core/routes/routes.dart';
import 'package:sportsbet/user%20view/Services/google_signin_service.dart';
import 'package:sportsbet/user%20view/Screens/Auth/Login/login_screen.dart';
import 'package:sportsbet/user%20view/Screens/Home/home_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth credentials = FirebaseAuth.instance;
  final GoogleSignInService googleSignInService = GoogleSignInService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;
  RxBool remmemberme = false.obs;
  RxBool termsAgree = false.obs;
  RxBool presssignin = false.obs;
  RxBool securePassword = true.obs;

  toggleSignup() {
    presssignin.toggle();
  }

  googleSignIn() {
    try {
      GoogleSignInService();
    } catch (e) {
      Get.snackbar('error', '$e');
    }
  }

  changeNumber(String val) {
    phoneNumber.value = val;

    update();
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );
      final UserCredential authResult =
          await auth.signInWithCredential(authCredential);
      final User user = authResult.user!;
      if (user.phoneNumber == null) {
        await changeNumber(user.uid);
        await UserPreference.setUserId(user.uid);
        phoneNumber.value = user.uid;
      } else {
        phoneNumber.value = user.phoneNumber.toString();
      }
      await UserPreference.setUserId(
        phoneNumber.value,
      );
      Map<String, dynamic> userData = {
        'name': user.displayName,
        'email': user.email,
        'phoneNumber': phoneNumber.value,
        'uid': user.uid,
        'password': user.uid
      };

      await FirebaseFirestore.instance
          .collection("User Information")
          .doc(phoneNumber.value)
          .set(userData)
          .then((value) async {
        await UserPreference.setIsLoggedIn(true);
        await Get.offAllNamed(Routes.onBoarding);
      });

      return authResult;
    } catch (e) {
      // print('Error signing in with Google --------------- : $e');
      rethrow;
    }
  }

  signinwithemail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '${phoneNumber.value}@gmail.com',
        //email: email.value,

        password: password.value,
      );

      await UserPreference.setUserId(phoneNumber.value.toString());
      if (remmemberme.value == true) {
        await UserPreference.setIsLoggedIn(true);
      } else {
        await UserPreference.setIsLoggedIn(false);
      }
      Get.offAll(() => const HomeScreen());
      // Get.offAll(() => const HomeScreen());
      presssignin.value = false;
    } catch (e) {
      // Display the exception in a snack-bar
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
