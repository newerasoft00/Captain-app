import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/View/Screens/Auth/Login/Componant/custom_textfield.dart';
import '../../../../Controller/Auth/signup_controller.dart';
import '../../../../Core/utils/color.dart';
import '../../../../Core/utils/text_style.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                Container(
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Get.isDarkMode
                                ? const Color.fromARGB(255, 63, 63, 63)
                                : const Color(0xFFd9d9d9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntlPhoneField(
                          decoration: const InputDecoration(
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: MyColors.maincolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      controller.toggleSignup();
                      if (controller.formKey.currentState!.validate()) {
                        // Show CircularProgressIndicator
                        controller.presssignup.value = true;

                        controller.signupwithemail();

                        // Hide CircularProgressIndicator
                        controller.presssignup.value = false;
                        //Get.to(() => const HomeScreen());
                      }
                      controller.toggleSignup();
                    },
                    child: Obx(() {
                      return controller.presssignup.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            ) // Show CircularProgressIndicator
                          : const Text(
                              'Sign up',
                              style: tajawalblue22,
                            );
                    }),
                  ),
                ),
                20.ph
              ],
            ),
          ),
        ),
      ),
    );
  }
}
