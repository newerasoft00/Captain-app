import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Auth/phone_controller.dart';

class OtpScreen extends StatelessWidget {
  final loginController = Get.put(PhoneController());
  final otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Spacer(),
          TextField(
            controller: otp,
            decoration: InputDecoration(
              hintText: "Enter OTP",
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                loginController.verifyOTP(otp.text);
              },
              child: Text('ssssssssssss'))
        ],
      )),
    );
  }
}
