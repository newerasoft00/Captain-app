import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/user%20view/Controller/Auth/signup_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/Componant/otp.dart';

import '../../../../../Core/helper/shared_preference/shared_preference.dart';
import 'Componant/custom_textfield.dart';
import 'Componant/terms_of_use.dart';
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
                      suffixcolor: Theme.of(context).primaryColor,
                      suffixicon: Icons.person,
                      hint: 'Enter your name'.tr,
                      onChanged: (val) {
                        controller.name.value = val;
                      }),
                  15.ph,
                  CustomTextField(
                      suffixcolor: Theme.of(context).primaryColor,
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
                            ? Colors.teal.shade700
                            : Theme.of(context).primaryColor,
                        onTapSuffix: () {
                          controller.togglepasswordEye();
                        },
                        visible: !controller.visiblepassword.value,
                        suffixicon: !controller.visiblepassword.value
                            ? Icons.visibility_off
                            : Icons.visibility_outlined,
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
                          ? Colors.teal.shade700
                          : Theme.of(context).primaryColor,
                      onTapSuffix: () {
                        controller.togglecheckpasswordEye();
                      },
                      suffixicon: !controller.visiblecheckpassword.value
                          ? Icons.visibility_off
                          : Icons.visibility_outlined,
                      hint: 'Re Enter your password'.tr,
                      onChanged: (val) {
                        controller.checkpassword.value = val;
                      })),
                  15.ph,
                  SizedBox(
                    width: Get.width,
                    child: Obx(() => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            backgroundColor: Theme.of(context).cardColor,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: controller.termsAgree.value == true
                              ? () async {
                                  controller.toggleSignup();
                                  controller.presssignup.value = true;
                                  await UserPreference.setUserId(
                                      controller.phoneNumber.value);
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.verifyPhone(
                                        controller.phoneNumber.value);
                                    Get.to(OtpScreen(
                                        phoneNumber:
                                            controller.phoneNumber.value));
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
