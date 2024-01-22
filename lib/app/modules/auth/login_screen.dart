import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:captain/app/utils/Core/helper/empty_padding.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:captain/app/utils/Core/helper/log_printer.dart';
import 'package:captain/app/utils/Core/themes/app_text_theme.dart';
import 'package:captain/app/widgets/custom_appbar.dart';
import '../../routes/routes.dart';
import 'Componant/otp.dart';
import 'Componant/terms_of_use.dart';
import 'cotroller/login_controller.dart';
import 'cotroller/signup_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    final SignupController signupController = Get.put(SignupController());
    return Scaffold(
      appBar: const CustomAppBar(isBackButtonExist: false),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Padding(
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
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.3))),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: IntlPhoneField(
                          showDropdownIcon: false,
                          pickerDialogStyle: PickerDialogStyle(
                            countryNameStyle: poppinsMedium.copyWith(
                                color: Theme.of(context).colorScheme.secondary),
                            countryCodeStyle: poppinsMedium.copyWith(
                                color: Theme.of(context).colorScheme.secondary),
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
                            logError(signupController.phoneNumber.value);
                          },
                        ),
                      ),
                    ),
                    30.ph,
                    SizedBox(
                      width: Get.width,
                      height: 45,
                      child: Obx(() => ElevatedButton(
                            onPressed: controller.termsAgree.value == true
                                ? () async {
                                    controller.toggleSignup();
                                    if (signupController.phoneNumber.value !=
                                        '') {
                                      final bool isOTPSent =
                                          await signupController.verifyPhone(
                                              signupController
                                                  .phoneNumber.value);

                                      if (isOTPSent) {
                                        Get.to(() => OtpScreen(
                                              phoneNumber: signupController
                                                  .phoneNumber.value,
                                              isSignIn: true,
                                            ));
                                      } else {
                                        signupController.showSnakBar();
                                      }
                                    }
                                    controller.toggleSignup();
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
                      child: Obx(() => GetPlatform.isIOS
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SignInButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  elevation: 5,
                                  mini: true,
                                  Buttons.email,
                                  onPressed: controller.termsAgree.value == true
                                      ? () async {
                                          await _handleGoogleSignIn(controller);
                                        }
                                      : () {},
                                ),
                                10.pw,
                                SignInButton(
                                  elevation: 5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  mini: true,
                                  Buttons.apple,
                                  onPressed: () {},
                                )
                              ],
                            )
                          : controller.presssignin.value
                              ? const CircleAvatar(
                                  radius: 35,
                                  child: CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.white),
                                ) // Replace with a circular progress indicator
                              : SignInButtonBuilder(
                                  text: 'Sign in with Email',
                                  icon: Icons.email,
                                  onPressed: controller.termsAgree.value == true
                                      ? () async {
                                          await _handleGoogleSignIn(controller);
                                        }
                                      : () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  backgroundColor:
                                      controller.termsAgree.value == true
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.15),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
        ],
      ),
    );
  }

  Future<void> _handleGoogleSignIn(AuthController controller) async {
    controller.toggleGmail();
    try {
      await controller.signInWithGoogle();
    } catch (e) {
      Get.snackbar('Erorr', 'Error during Google Sign In',
          backgroundColor: Colors.red);
    } finally {
      controller.toggleGmail();
    }
  }
}
