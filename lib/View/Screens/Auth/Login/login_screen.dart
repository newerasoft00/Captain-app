import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Core/utils/color.dart';
import 'package:sportsbet/View/Screens/Auth/Login/Componant/custom_textfield.dart';
import 'package:sportsbet/View/Screens/Auth/Login/signup_screen.dart';
import '../../../../Controller/Auth/login_controller.dart';

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
              25.ph,
              SizedBox(
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
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
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntlPhoneField(
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
                ),
              )),
              30.ph,
              /* 123456Aa@ */
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
                  Obx(
                    () => CupertinoCheckbox(
                        value: controller.remmemberme.value,
                        onChanged: (val) {
                          controller.remmemberme.value = val!;
                        }),
                  ),
                  3.pw,
                  const Text(
                    'Remember me',
                  ),
                ],
              ),
              20.ph,
              SizedBox(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    controller.presssignin.value = true;
                    if (controller.phoneNumber.value != '' ||
                        controller.password.value != '') {
                      await controller.signinwithemail();
                    }
                    controller.presssignin.value = false;
                  },
                  child: Obx(() {
                    return controller.presssignin.value
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          ) // Show CircularProgressIndicator
                        : const FittedBox(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
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
                              color: Color(0xff0061A4),
                            ),
                          ),
                          TextSpan(
                            text: " Register",
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
    );
  }
}
