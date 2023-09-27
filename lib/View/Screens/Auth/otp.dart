import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';
import 'package:sportsbet/res/i_font_res.dart';
import '../../../Controller/Auth/signup_controller.dart';
import '../../../Core/helper/shared_preference/shared_preference.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    final c = Get.put(SignupController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height * 0.35,
              child: Stack(children: [
                Opacity(
                  opacity: 0.20,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.4,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF0061A4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(250),
                        bottomLeft: Radius.circular(250),
                      )),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      'assets/Image/pana.png',
                      width: Get.width * 0.75,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      c.presssignup.value = false;
                      c.stopTimer();
                      Get.back();
                    },
                  ),
                ),
              ]),
            ),
            20.ph,
            const Text(
              'OTP Verification',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontFamily: FontRes.TAJAWAL_BOLD,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            20.ph,
            Text.rich(
              TextSpan(children: [
                const TextSpan(
                  text: 'We Will send you a one time password on\n\n this  ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
              textAlign: TextAlign.center,
            ),
            20.ph,
            OTPTextField(
              length: 6,
              width: Get.width - 60,
              fieldWidth: Get.width * 0.11,
              style: const TextStyle(fontSize: 15),
              textFieldAlignment: MainAxisAlignment.spaceBetween,
              fieldStyle: FieldStyle.box,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) {},
              otpFieldStyle: OtpFieldStyle(
                focusBorderColor: Theme.of(context).primaryColor,
              ),
              keyboardType: TextInputType.number,
              outlineBorderRadius: Get.width * 0.09,
              onCompleted: (pin) async {
                c.verficationotp.value = pin;
                print("Completed: $pin");
                print("Phone is : ${c.phoneNumber.value.toString()}");
                await UserPreference.setUserId(c.phoneNumber.value.toString());
                Get.to(const HomeScreen());
                print(UserPreference.getUserid().toString());
                print('+++++++++++++++++++++++++++++++');

                //c.verifyOTP(pin);
                print(UserPreference.getUserid().toString());
                print('----------------------------------------------------');
              },
            ),
            Obx(
              () => Text(
                '00 : ${c.countdown}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
            10.ph,
            TextButton(
              onPressed: () {
                c.verifyPhone(c.phoneNumber.value);
              },
              child: const Text(
                'Send OTP again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0061A4),
                  fontSize: 12,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
