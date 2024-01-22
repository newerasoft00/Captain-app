import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/utils/Core/helper/empty_padding.dart';

import '../../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../cotroller/signup_controller.dart';
import 'custom_textfield.dart';

Widget userInformation({
  required BuildContext context,
}) {
  final SignupController controller = Get.put(SignupController());
  return Column(
    children: [
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
            if (controller.formKey.currentState!.validate()) {
              controller.verifyPhone(controller.phoneNumber.value);
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
    ],
  );
}
