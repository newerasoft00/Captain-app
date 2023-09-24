import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';

class PhoneController extends GetxController {
  var authState = ''.obs;
  String verificationID = '';
  var auth = FirebaseAuth.instance;

  //sent code
  verifyPhone(String phone) async {
    auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {},
        verificationFailed: (authException) {},
        codeSent: (String id, [int? forceResent]) {
          verificationID = id;
          authState.value = 'codeSent successfully';
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

      // Sign in with the credential
      await auth.signInWithCredential(credential);
      Get.to(() => const HomeScreen());
      // You can perform actions after successful verification here
      authState.value = 'Phone number verified successfully';
    } catch (e) {
      // Handle errors during OTP verification here
      print('Error verifying OTP: $e');
      authState.value = 'Error verifying OTP: $e';
    }
  }
}
