import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';
import '../../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../cotroller/phone_controller.dart';
import '../cotroller/signup_controller.dart';
import 'custom_textfield.dart';

class PhoneInputPage extends StatelessWidget {
  final PhoneController phoneController = Get.find();
  final SignupController controller = Get.put(SignupController());

  PhoneInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                child: Image.asset('assets/Roshn_Saudi_League_Logo.svg.png')),
            12.ph,
            Text(
              'Sign Up now'.tr,
              textAlign: TextAlign.center,
            ),
            20.ph,
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntlPhoneField(
                      keyboardType: TextInputType.phone,
                      pickerDialogStyle: PickerDialogStyle(
                        backgroundColor: Theme.of(context).cardColor,
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  controller.toggleSignup();
                  controller.presssignup.value = true;
                  await UserPreference.setUserId(controller.phoneNumber.value);
                  if (controller.formKey.currentState!.validate() &&
                      controller.phoneNumber.value != '') {
                    controller.verifyPhone(controller.phoneNumber.value);
                    controller.pageController.initialPage == 1;
                    controller.presssignup.value = false;
                  }
                  controller.toggleSignup();
                },
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
              ),
            ),
            20.ph,
          ],
        ),
      ),
    );
  }
}
