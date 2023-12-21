// SignUpScreen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';
import '../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../../utils/Core/themes/app_text_theme.dart';
import 'Componant/custom_textfield.dart';
import 'Componant/otp.dart';
import 'Componant/terms_of_use.dart';
import 'cotroller/signup_controller.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 45, bottom: 16, right: 16, left: 16),
            child: SizedBox(
              height: context.height - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                      width: Get.width / 4,
                      height: Get.width / 4,
                      child: Image.asset(
                          'assets/Roshn_Saudi_League_Logo.svg.png')),
                  12.ph,
                  Text(
                    'Sign Up now'.tr,
                    textAlign: TextAlign.center,
                  ),
                  20.ph,
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5))),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: IntlPhoneField(
                            keyboardType: TextInputType.phone,
                            pickerDialogStyle: PickerDialogStyle(
                              countryNameStyle: poppinsMedium.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              countryCodeStyle: poppinsMedium.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                hintText: 'Phone Number'.tr,
                                hintStyle: const TextStyle(fontSize: 16)),
                            initialCountryCode: 'SA',
                            onChanged: (phone) {
                              controller.phoneNumber.value =
                                  phone.completeNumber.toString();
                            },
                          ))),
                  15.ph,
                  CustomTextField(
                      validator: controller.validateName,
                      suffixcolor: Theme.of(context).colorScheme.secondary,
                      suffixicon: Icons.person,
                      hint: 'Enter your name'.tr,
                      onChanged: (val) {
                        controller.name.value = val;
                      }),
                  15.ph,
                  CustomTextField(
                      suffixcolor: Theme.of(context).colorScheme.secondary,
                      suffixicon: Icons.email,
                      hint: 'Enter your email'.tr,
                      onChanged: (val) {
                        controller.email.value = val;
                      }),
                  15.ph,
                  Obx(
                    () => CustomTextField(
                        validator: controller.validpassword,
                        suffixcolor: controller.visiblepassword.value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        onTapSuffix: () {
                          controller.togglepasswordEye();
                        },
                        visible: !controller.visiblepassword.value,
                        suffixicon: !controller.visiblepassword.value
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        hint: 'Enter your password'.tr,
                        onChanged: (val) {
                          controller.password.value = val;
                        }),
                  ),
                  15.ph,
                  Obx(() => CustomTextField(
                      validator: controller.passwordmatch,
                      visible: !controller.visiblecheckpassword.value,
                      suffixcolor: controller.visiblecheckpassword.value
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      onTapSuffix: () {
                        controller.togglecheckpasswordEye();
                      },
                      suffixicon: !controller.visiblecheckpassword.value
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      hint: 'Re Enter your password'.tr,
                      onChanged: (val) {
                        controller.checkpassword.value = val;
                      })),
                  15.ph,
                  SizedBox(
                    width: Get.width,
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.termsAgree.value == true
                              ? () async {
                                  controller.toggleSignup();
                                  controller.presssignup.value = true;
                                  await UserPreference.setUserId(
                                      controller.phoneNumber.value);
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    await controller.verifyPhone(
                                        controller.phoneNumber.value);
                                    final bool isOTPSent =
                                        await controller.verifyPhone(
                                            controller.phoneNumber.value);

                                    if (isOTPSent) {
                                      Get.to(() => OtpScreen(
                                                phoneNumber: controller
                                                    .phoneNumber.value,
                                                isSignIn: false,
                                              ))!
                                          .then((value) =>
                                              controller.toggleSignup());
                                    } else {
                                      controller.showSnakBar();
                                    }

                                    controller.presssignup.value = false;
                                  }
                                  controller.toggleSignup();
                                }
                              : null,
                          child: Obx(() {
                            return controller.presssignup.value
                                ? const CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  )
                                : FittedBox(
                                    child: Text(
                                      'Sign up'.tr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                          }),
                        )),
                  ),
                  20.ph,
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "already have account? ".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.8),
                                ),
                              ),
                              TextSpan(
                                text: "Sign in".tr,
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
                  const Spacer(
                    flex: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => CupertinoCheckbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: controller.termsAgree.value,
                              onChanged: (val) {
                                controller.termsAgree.value = val!;
                              }),
                        ),
                        3.pw,
                        const TermsOfUse()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
