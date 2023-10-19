import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Core/routes/routes.dart';
import 'package:sportsbet/user%20view/Controller/Auth/login_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/Componant/otp.dart';

import '../../../../../../Core/helper/shared_preference/shared_preference.dart';
import '../../../../Controller/Auth/signup_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    final SignupController signupController = Get.put(SignupController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              25.ph,
              SizedBox(
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
                  child: Image.asset('assets/Roshn_Saudi_League_Logo.svg.png')),
              Text(
                'Welcome'.tr,
                textAlign: TextAlign.center,
              ),
              20.ph,
              Text(
                'By signing in you are agreeing our\nTerm and privacy policy'
                    .tr,
                textAlign: TextAlign.center,
              ),
              30.ph,
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: IntlPhoneField(
                      pickerDialogStyle: PickerDialogStyle(
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: 'Phone Number'.tr,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Get.isDarkMode
                                  ? Theme.of(context).hintColor
                                  : Colors.black38)),
                      initialCountryCode: 'SA',
                      onChanged: (phone) {
                        signupController.phoneNumber.value =
                            phone.completeNumber.toString();
                      },
                    ),
                  ),
                ),
              ),
              30.ph,
              // CustomTextField(
              //     visible: controller.securePassword.value,
              //     onTapSuffix: () {
              //       controller.securePassword.value = false;
              //     },
              //     suffixcolor: Colors.grey,
              //     suffixicon: Icons.lock_outline,
              //     hint: 'Password'.tr,
              //     onChanged: (val) {
              //       controller.password.value = val;
              //     }),
              //10.ph,
              Row(
                children: [
                  Obx(
                    () => CupertinoCheckbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: controller.remmemberme.value,
                        onChanged: (val) {
                          controller.remmemberme.value = val!;
                        }),
                  ),
                  3.pw,
                  Text(
                    'Remember me'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              20.ph,
              SizedBox(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    controller.presssignin.value = true;
                    if (signupController.phoneNumber.value != '') {
                      UserPreference.setUserId(controller.phoneNumber.value);

                      // Call the signInWithPhoneNumber method to check if the user has signed up before
                      final bool isExistingUser = await signupController
                          .signInWithPhoneNumber(controller.phoneNumber.value);

                      if (isExistingUser) {
                        // User has signed up before, navigate to the OTP screen
                        Get.to(() => OtpScreen(
                              phoneNumber: signupController.phoneNumber.value,
                            ));
                        controller.presssignin.value = false;
                      } else {
                        // User is signing in for the first time, you can handle it accordingly
                        // For example, show a message or take some other action
                        signupController.showSnakBar();
                        controller.presssignin.value = false;
                      }
                    }
                    controller.presssignin.value = false;
                  },
                  child: Obx(() {
                    return controller.presssignin.value
                        ? const CircularProgressIndicator
                            .adaptive() // Show CircularProgressIndicator
                        : FittedBox(
                            child: Text(
                              'Sign in'.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          );
                  }),
                ),
              ),
              25.ph,
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.signupScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "don't have an account ? ".tr,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: " Register".tr,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              10.ph,
              const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 5,
                      indent: 5,
                    ),
                  ),
                  AutoSizeText(' OR '),
                  Expanded(
                    child: Divider(
                      endIndent: 5,
                      indent: 5,
                    ),
                  ),
                ],
              ),
              10.ph,
              SizedBox(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    await controller.signInWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Image/google icon_.png'),
                      10.pw,
                      FittedBox(
                          child: Text(
                        'Sign in with  Google'.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
