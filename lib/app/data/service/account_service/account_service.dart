import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/routes/routes.dart';
import 'package:captain/app/utils/Core/helper/log_printer.dart';
import 'package:captain/app/utils/Core/helper/shared_preference/shared_preference.dart';

class DeleteAccountService {
  Future<void> deleteUserAccount(String userID) async {
    try {
      // Delete user account from Firebase Authentication
      await FirebaseAuth.instance.currentUser?.delete();

      // Delete user data from Firestore
      await FirebaseFirestore.instance
          .collection('User Information')
          .doc(userID)
          .delete();

      // Logout the user
      await FirebaseAuth.instance.signOut();

      // set User Not LogedIn
      await UserPreference.setIsLoggedIn(false);

      // Navigate to the login screen or any other screen after deletion
      Get.offAllNamed(Routes.loginscreen);
    } catch (error) {
      // Handle errors, show snackbar, or perform any necessary actions
      logError('Error deleting user account: $error');
    }
  }

  Future<AwesomeDialog> showDeleteConfirmationDialog(
      String userID, BuildContext context) async {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      body: const Center(
        child: Text(
          'هل انت متاكد من رغبتك في حذف الحساب ؟',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      title: '',
      desc: '',
      btnOkOnPress: () async {
        await deleteUserAccount(userID);
      },
    )..show();
  }
}
