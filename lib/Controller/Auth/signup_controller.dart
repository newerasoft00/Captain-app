import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';

class SignupController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth credentials = FirebaseAuth.instance;
  RxString phoneNumber = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString checkpassword = ''.obs;
  RxBool visiblepassword = false.obs;
  RxBool visiblecheckpassword = false.obs;
  RxBool presssignup = false.obs;

  String specialCharacters = r'!@#$%^&*(),.?":{}|<>';

  final formKey = GlobalKey<FormState>();
  //inal buttonformKey = GlobalKey<FormState>();

  bool _containsSpecialCharacters(String value) {
    // Define the list of special characters that are not allowed in the name

    for (var char in value.characters) {
      if (specialCharacters.contains(char)) {
        return true;
      }
    }
    return false;
  }

  togglepasswordEye() {
    visiblepassword.toggle();
  }

  togglecheckpasswordEye() {
    visiblecheckpassword.toggle();
  }

  toggleSignup() {
    presssignup.toggle();
  }

  // Firebase Sign Up

  void signupwithemail() async {
    try {
      if (name.value != '' &&
          phoneNumber.value.toString() != '' &&
          password.value != '' &&
          checkpassword.value == password.value) {
        final UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: '${phoneNumber.value.toString()}@gmail.com',
          password: password.value,
        );

        // User creation successful
        String userId = userCredential.user!.uid; // Get the user ID

        // Create a map with the user data
        Map<String, dynamic> userData = {
          'name': name.value,
          'email': email.value,
          'phoneNumber': phoneNumber.value.toString(),
          'password': password.value,
          'uid': userId,
        };

        // Store the user data in Firestore
        await FirebaseFirestore.instance
            .collection("User Information")
            .doc(phoneNumber.value.toString())
            .set(userData)
            .then((value) {
          UserPreference.setUserId(phoneNumber.value.toString());
          Get.to(() => const HomeScreen());
        });

        Get.snackbar(
          'Success',
          'Your account has been created',
          backgroundColor: Colors.greenAccent,
          duration: const Duration(seconds: 1),
        );
      } else if (password.value != checkpassword.value) {
        Get.snackbar(
          'Error',
          'Password is too weak',
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create user: $e',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      );
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (_containsSpecialCharacters(value)) {
      return 'Name should not include special characters';
    }
    return null;
  }

  String? validpassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Define your desired password strength requirements
    final bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    final bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
    final bool hasDigits = value.contains(RegExp(r'[0-9]'));
    final bool hasSpecialCharacters =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Build the error message based on the missing requirements
    String errorMessage = 'Password should include:';
    if (!hasUpperCase) {
      errorMessage += '\n- One uppercase letter';
    }
    if (!hasLowerCase) {
      errorMessage += '\n- One lowercase letter';
    }
    if (!hasDigits) {
      errorMessage += '\n- One digit';
    }
    if (!hasSpecialCharacters) {
      errorMessage += '\n- One special character';
    }

    // If all requirements are met, return null (no error)
    if (hasUpperCase && hasLowerCase && hasDigits && hasSpecialCharacters) {
      if (value.length < 8) {
        return 'Password should be at least 8 characters long';
      }
      return null;
    }
    return errorMessage;
  }

  String? passwordmatch(String? value) {
    if (password.value != checkpassword.value) {
      return "Password don't match";
    }
    return null;
  }
}
