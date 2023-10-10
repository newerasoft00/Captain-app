import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/user%20view/Controller/Auth/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: Get.width / 2,
                height: Get.width / 2,
                child: Image.asset('assets/Image/Admin-amico.png')),
            20.ph,
            TextFormField(
              onChanged: (value) {
                controller.email.value = value;
              },
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            10.ph,
            TextFormField(
              onChanged: (value) {
                controller.password.value = value;
              },
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            20.ph,
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FilledButton(
                      onPressed: () async {
                        await UserPreference.setIsLoggedIn(true);
                        controller.remmemberme.value = true;
                        controller.signinwithemail();
                      },
                      child: const Text('Login')),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
