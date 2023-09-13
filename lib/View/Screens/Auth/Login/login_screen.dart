import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Core/utils/color.dart';
import 'package:sportsbet/View/Screens/Auth/Login/Componant/custom_textfield.dart';
import 'package:sportsbet/View/Screens/Auth/Login/signup_screen.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';
import '../../../../Controller/Auth/login_controller.dart';
import '../../../../Services/lineapp.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
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
              40.ph,
              SizedBox(
                  width: Get.width / 2.5,
                  height: Get.width / 2.5,
                  child: Image.asset('assets/Roshn_Saudi_League_Logo.svg.png')),
              const Text(
                'Welcome',
                textAlign: TextAlign.center,
              ),
              20.ph,
              const Text(
                'By signing in you are agreeing our\nTerm and privacy policy',
                textAlign: TextAlign.center,
              ),
              30.ph,
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
                        /*  border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ), */
                      ),
                      initialCountryCode: 'SA',
                      onChanged: (phone) {
                        controller.phoneNumber.value = phone.completeNumber.toString();
                      },
                    ),
                  )),
              30.ph,
              CustomTextField(
                  suffixcolor: MyColors.grayhint,
                  suffixicon: Icons.email_outlined,
                  hint: 'Email',
                  onChanged: (val) {
                    controller.email.value = val;
                  }),
              25.ph,
              CustomTextField(
                  visible: controller.securePassword.value,
                  onTapSuffix: () {
                    controller.securePassword.value = false;
                  },
                  suffixcolor: MyColors.grayhint,
                  suffixicon: Icons.lock_outline,
                  hint: 'Password',
                  onChanged: (val) {
                    controller.password.value = val;
                  }),
              10.ph,
              Row(
                children: [
                  CupertinoCheckbox(value: true, onChanged: (val) {}),
                  3.pw,
                  const Text(
                    'Remember me',
                  ),
                ],
              ),
              20.ph,
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: MyColors.maincolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      if (controller.email.value != '' ||
                          controller.password.value != '') {
                        await controller.signinwithemail();
                      }
                    },
                    child: const Text(
                      'Login',
                    )),
              ),
              25.ph,
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      FootballApiClient();
                      Get.to(() => const SignUpScreen());
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "don't have an account ? ",
                            style: TextStyle(
                                fontFamily: '',
                                fontSize: 16,
                                color: Color.fromARGB(188, 33, 149, 243)),
                          ),
                          TextSpan(
                            text: " Register",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
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
    );
  }
}
