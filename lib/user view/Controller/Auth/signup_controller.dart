import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/user%20view/Screens/Home/home_screen.dart';
import 'package:sportsbet/user%20view/Screens/on_boarding/on_boarding_screen.dart';
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/Componant/otp.dart';

class SignupController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth credentials = FirebaseAuth.instance;
  Timer? _timer;
  final PageController pageController = PageController(initialPage: 0);
  var authState = ''.obs;
  String verificationID = '';
  RxString verficationotp = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString checkpassword = ''.obs;
  RxBool visiblepassword = false.obs;
  RxBool visiblecheckpassword = false.obs;
  RxBool presssignup = false.obs;
  RxBool termsAgree = false.obs;
  RxInt countdown = 60.obs;
  String specialCharacters = r'!@#$%^&*(),.?":{}|<>';

  final formKey = GlobalKey<FormState>();

  bool _containsSpecialCharacters(String value) {
    // Define the list of special characters that are not allowed in the name

    for (var char in value.characters) {
      if (specialCharacters.contains(char)) {
        return true;
      }
    }
    return false;
  }

  void stopTimer() {
    _timer?.cancel();
  }

  // Add this method to your SignupController class

  Future<bool> signInWithPhoneNumber(String phone) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: verficationotp.value,
      );

      // Sign in with the credential
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Check if the user exists in your Firestore collection
        final DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection("User Information")
            .doc(phone)
            .get();

        if (userData.exists) {
          await verifyPhone(phone);
          Get.to(() => OtpScreen(phoneNumber: phone));
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in: $e');
      }
    }

    return false; // Default to returning false if there's an error
  }

  showSnakBar() {
    return Get.snackbar(
            backgroundColor: Colors.red,
            'error',
            'Create account first',
            colorText: Colors.white,
            duration: const Duration(seconds: 5))
        .show();
  }

  //sent code
  verifyPhone(String phone) async {
    auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {},
        verificationFailed: (authException) {},
        codeSent: (String id, [int? forceResent]) {
          verificationID = id;
          authState.value = 'codeSent successfully';
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            countdown.value = 60 - timer.tick;
            if (timer.tick >= 60) {
              authState.value = 'Verification timeout';
              timer.cancel(); // Cancel the timer
            }
          });
        },
        codeAutoRetrievalTimeout: (id) {
          verificationID = id;
        },
        timeout: const Duration(seconds: 60));
  }

  //verify code
  verifyOTP(String otp) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      );

      // Sign in with the credential to verify the OTP
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        if (name.value != '' &&
            phoneNumber.value.toString() != '' &&
            password.value != '' &&
            checkpassword.value == password.value) {
          Map<String, dynamic> userData = {
            'name': name.value,
            'email': email.value,
            'phoneNumber': phoneNumber.value.toString(),
            'password': password.value,
            'uid':
                userCredential.user!.uid, // Use the UID from the signed-in user
          };

          await FirebaseFirestore.instance
              .collection("User Information")
              .doc(phoneNumber.value.toString())
              .set(userData)
              .then((value) async {
            Get.to(() => const OnBoardingScreen());
            await UserPreference.setIsLoggedIn(true);
            await UserPreference.setUserId(phoneNumber.value.toString());
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
            duration: const Duration(seconds: 3),
          );
        }

        // Proceed to the HomeScreen after successful sign-up
        Get.to(() => const HomeScreen());
        authState.value = 'Phone number verified successfully';
      } else {
        // Handle the case where the OTP is incorrect
        Get.snackbar(
          'Error',
          'Invalid OTP',
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      return Get.snackbar(
        'Error',
        'Please check and enter the correct verification code again.',
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 5),
      );
    }
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
          Get.offAll(() => const HomeScreen());
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

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
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

  @override
  void dispose() {
    pageController.dispose();
    presssignup = false.obs;
    super.dispose();
  }

  @override
  void onClose() {
    presssignup = false.obs;
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    presssignup = false.obs;
  }
}
