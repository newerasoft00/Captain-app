import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

import '../Core/helper/shared_preference/shared_preference.dart';
class ImagePickerController extends GetxController {
  RxString imagePath = RxString('');
  RxBool isLoading = RxBool(false);

  // Initialize the image path from SharedPreferences
  Future<void> initImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImagePath = prefs.getString('user_image_url');
    if (savedImagePath != null) {
      imagePath.value = savedImagePath;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      isLoading.value = true;

      final File imageFile = File(pickedImage.path);
      final fileName = UserPreference.getUserid();

      try {
        final firebaseStorageRef =
            firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        final uploadTask = firebaseStorageRef.putFile(imageFile);
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Save the downloadUrl in local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_image_url', downloadUrl);

        imagePath.value = downloadUrl;
        isLoading.value = false;
      } catch (error) {
        isLoading.value = false;
        showDialog(
          context: Get.context!,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred!'),
            content: const Text('Something went wrong. Please try again.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      }
    }
  }
}
