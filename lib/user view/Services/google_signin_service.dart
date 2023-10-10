import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Core/helper/shared_preference/shared_preference.dart';
import '../View/Screens/Home/home_screen.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null; // User cancelled the Google Sign-In
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        // You can access user data here
        final String? displayName = user.displayName;
        final String? phoneNumber = user.phoneNumber;
        final String uid = user.uid;
        final String? email = user.email;

         Map<String, dynamic> userData = {
          'name': displayName,
          'email': email,
          'phoneNumber': phoneNumber,
          'uid': uid,
        };
        await FirebaseFirestore.instance
            .collection("User Information")
            .doc(phoneNumber)
            .set(userData)
            .then((value) {
          UserPreference.setUserId(phoneNumber!);
          Get.to(() => const HomeScreen());
        });
        return user;
      }
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }

    return null;
  }
}
