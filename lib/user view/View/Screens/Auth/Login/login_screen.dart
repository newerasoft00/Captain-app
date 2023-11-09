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
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/Componant/terms_of_use.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(shrinkWrap: true, children: [
          SizedBox(
            height: context.height - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                (context.height < 400)
                    ? const SizedBox()
                    : SizedBox(
                        width: Get.width * 0.2,
                        height: Get.width * 0.2,
                        child: Image.asset(
                            'assets/Roshn_Saudi_League_Logo.svg.png')),
                AutoSizeText(
                  'Welcome'.tr,
                  textAlign: TextAlign.center,
                  maxFontSize: 42,
                  minFontSize: 36,
                  wrapWords: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                20.ph,
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: IntlPhoneField(
                      pickerDialogStyle: PickerDialogStyle(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
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
                30.ph,
                SizedBox(
                  width: Get.width,
                  height: 45,
                  child: Obx(() => FilledButton(
                        style: FilledButton.styleFrom(
                            disabledBackgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5)),
                        onPressed: controller.termsAgree.value == true
                            ? () async {
                                controller.presssignin.value = true;
                                if (signupController.phoneNumber.value != '') {
                                  UserPreference.setUserId(
                                      controller.phoneNumber.value);
                                  final bool isExistingUser =
                                      await signupController
                                          .signInWithPhoneNumber(
                                              controller.phoneNumber.value);
                                  if (isExistingUser) {
                                    Get.to(() => OtpScreen(
                                          phoneNumber: signupController
                                              .phoneNumber.value,
                                        ));
                                    controller.presssignin.value = false;
                                  } else {
                                    signupController.showSnakBar();
                                    controller.presssignin.value = false;
                                  }
                                }
                                controller.presssignin.value = false;
                              }
                            : null,
                        child: Obx(() {
                          return controller.presssignin.value
                              ? const CircularProgressIndicator
                                  .adaptive() // Show CircularProgressIndicator
                              : AutoSizeText(
                                  'Log in'.tr,
                                  maxFontSize: 22,
                                  minFontSize: 18,
                                  wrapWords: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                );
                        }),
                      )),
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
                  child: Obx(() => FilledButton(
                        style: FilledButton.styleFrom(
                            disabledBackgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5)),
                        onPressed: controller.termsAgree.value == true
                            ? () async {
                                await controller.signInWithGoogle();
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                  backgroundColor:
                                      controller.termsAgree.value == true
                                          ? Colors.white
                                          : Colors.white54,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Image.asset(
                                        'assets/Image/google icon_.png'),
                                  )),
                            ),
                            10.pw,
                            AutoSizeText(
                              'Sign in with  Google'.tr,
                              minFontSize: 18,
                              maxFontSize: 22,
                              wrapWords: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                20.ph,
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
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.8),
                              ),
                            ),
                            TextSpan(
                              text: " Register".tr,
                              style: TextStyle(
                                  fontSize: 18,
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
                const Spacer(),
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
        ]),
      ),
    );
  }
}
