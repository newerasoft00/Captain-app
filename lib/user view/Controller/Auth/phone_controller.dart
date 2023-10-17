import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/user%20view/View/Screens/Home/home_screen.dart';


class PhoneController extends GetxController {
 
  var auth = FirebaseAuth.instance;
  final FirebaseAuth credentials = FirebaseAuth.instance;
  Timer? _timer;

   var authState = ''.obs;
  String verificationID = '';
  RxString verficationotp = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString checkpassword = ''.obs;
  RxInt countdown = 60.obs;


  void stopTimer() {
    _timer?.cancel();
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

  //verifycode
  verifyOTP(String otp) async {
    try {
       AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otp,
      );
      if (name.value != '' &&
          phoneNumber.value.toString() != '' &&
          password.value != '' &&
          checkpassword.value == password.value) {
        
        Map<String, dynamic> userData = {
          'name': name.value,
          'email': email.value,
          'phoneNumber': phoneNumber.value.toString(),
          'password': password.value,
          'uid': credential.token,
        };
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

      // Sign in with the credential
      await auth.signInWithCredential(credential);
      Get.to(() => const HomeScreen());
      // You can perform actions after successful verification here
      authState.value = 'Phone number verified successfully';
    } catch (e) {
      // Handle errors during OTP verification here
      // print('Error verifying OTP: $e');
      authState.value = 'Error verifying OTP: $e';
    }
  }
}
