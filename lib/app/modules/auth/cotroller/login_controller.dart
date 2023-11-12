import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../routes/routes.dart';
import '../../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../../home/home_screen.dart';
import '../login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxBool remmemberme = false.obs;
  final RxBool termsAgree = false.obs;
  final RxBool presssignin = false.obs;
  final RxBool securePassword = true.obs;

  bool get isSignedIn => _auth.currentUser != null;

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(authCredential);
      final User user = authResult.user!;

      if (user.phoneNumber == null) {
        changeNumber(user.uid);
        await UserPreference.setUserId(user.uid);
        phoneNumber.value = user.uid;
      } else {
        phoneNumber.value = user.phoneNumber.toString();
      }

      await UserPreference.setUserId(phoneNumber.value);

      Map<String, dynamic> userData = {
        'name': user.displayName,
        'email': user.email,
        'phoneNumber': phoneNumber.value,
        'uid': user.uid,
        'password': user.uid,
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
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: '${phoneNumber.value}@gmail.com',
        password: password.value,
      );

      await UserPreference.setUserId(phoneNumber.value.toString());
      await UserPreference.setIsLoggedIn(remmemberme.value);

      Get.offAll(() => const HomeScreen());
      presssignin.value = false;
    } catch (e) {
      Get.snackbar(
        'Error',
        "Error while signing in: $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      );
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
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

  void changeNumber(String val) {
    phoneNumber.value = val;
    update();
  }

  void toggleSignup() {
    presssignin.toggle();
  }

  @override
  void onClose() {
    phoneNumber.value = '';
    password.value = '';
    email.value = '';
    super.onClose();
  }
}
