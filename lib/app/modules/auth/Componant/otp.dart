import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';

import '../../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../cotroller/signup_controller.dart';

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
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.20,
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.4,
                      decoration: ShapeDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.18),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(250),
                            bottomLeft: Radius.circular(250),
                          ),
                        ),
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
                ],
              ),
            ),
            20.ph,
            AutoSizeText(
              'OTP Verification'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            20.ph,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'We Will send you a one time password on\n\n this '.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: phoneNumber,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
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
                focusBorderColor:
                    Theme.of(context).colorScheme.primaryContainer,
                backgroundColor: Theme.of(context).cardColor.withOpacity(0.18),
              ),
              keyboardType: TextInputType.number,
              outlineBorderRadius: Get.width * 0.09,
              onCompleted: (pin) async {
                c.verficationotp.value = pin;
                await c.verifyOTP(pin);
                await UserPreference.setUserId(c.phoneNumber.value.toString());
              },
            ),
            5.ph,
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
              child: AutoSizeText(
                'Send OTP again'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
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
