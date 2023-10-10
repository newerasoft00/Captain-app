import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/user%20view/Controller/Auth/phone_controller.dart';
import 'package:sportsbet/user%20view/Controller/Auth/signup_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/Componant/custom_textfield.dart';
import '../../../../../../Core/helper/shared_preference/shared_preference.dart';
import '../../../../../../Core/utils/color.dart';
import '../../../../../../Core/utils/text_style.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    final PhoneController phonecontroller = Get.put(PhoneController());

    return Scaffold(
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          // reverse: true,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 45, bottom: 16, right: 16, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: Get.width / 4,
                    height: Get.width / 4,
                    child:
                        Image.asset('assets/Roshn_Saudi_League_Logo.svg.png')),
                12.ph,
                const Text(
                  'Sign Up now',
                  textAlign: TextAlign.center,
                  style: tajawalb22,
                ),
                20.ph,
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntlPhoneField(
                          keyboardType: TextInputType.phone,
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Theme.of(context).cardColor,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                          ),
                          initialCountryCode: 'SA',
                          
                          onChanged: (phone) {
                            controller.phoneNumber.value =
                                phone.completeNumber.toString();
                          },
                        ))),
                15.ph,
                CustomTextField(
                    validator: controller.validateName,
                    suffixcolor: MyColors.grayhint,
                    suffixicon: Icons.person,
                    hint: 'Enter your name',
                    onChanged: (val) {
                      controller.name.value = val;
                    }),
                15.ph,
                CustomTextField(
                    suffixcolor: MyColors.grayhint,
                    suffixicon: Icons.email,
                    hint: 'Enter your email',
                    onChanged: (val) {
                      controller.email.value = val;
                    }),
                15.ph,
                Obx(
                  () => CustomTextField(
                      validator: controller.validpassword,
                      suffixcolor: controller.visiblepassword.value
                          ? MyColors.maincolor
                          : MyColors.grayhint,
                      onTapSuffix: () {
                        controller.togglepasswordEye();
                      },
                      visible: !controller.visiblepassword.value,
                      suffixicon: !controller.visiblepassword.value
                          ? Icons.visibility_off
                          : Icons.visibility_outlined,
                      hint: 'Enter your password',
                      onChanged: (val) {
                        controller.password.value = val;
                      }),
                ),
                15.ph,
                Obx(() => CustomTextField(
                    validator: controller.passwordmatch,
                    visible: !controller.visiblecheckpassword.value,
                    suffixcolor: controller.visiblecheckpassword.value
                        ? MyColors.maincolor
                        : MyColors.grayhint,
                    onTapSuffix: () {
                      controller.togglecheckpasswordEye();
                    },
                    suffixicon: !controller.visiblecheckpassword.value
                        ? Icons.visibility_off
                        : Icons.visibility_outlined,
                    hint: 'Re Enter your password',
                    onChanged: (val) {
                      controller.checkpassword.value = val;
                    })),
                15.ph,
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      controller.toggleSignup();
                      controller.presssignup.value = true;
                       await UserPreference.setUserId(controller.phoneNumber.value);
                      if (controller.formKey.currentState!.validate()) {
                        /* await phonecontroller
                            .verifyPhone(controller.phoneNumber.value);
                        Get.to(()=>OtpScreen(
                          phoneNumber: controller.phoneNumber.value,
                        )); */
                        controller.signupwithemail();

                        // Hide CircularProgressIndicator
                        controller.presssignup.value = false;
                        //Get.to(() => const HomeScreen());
                      }
                      controller.toggleSignup();
                    },
                    child: Obx(() {
                      return controller.presssignup.value
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            ) // Show CircularProgressIndicator
                          : const FittedBox(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            );
                    }),
                  ),
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
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "already have account? ",
                              style: TextStyle(
                                fontFamily: '',
                                fontSize: 16,
                                color: Color(0xff0061A4),
                              ),
                            ),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff0061A4),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
