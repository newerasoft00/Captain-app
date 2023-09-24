import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/View/Screens/Auth/otp.dart';
import '../../../Controller/Auth/phone_controller.dart';

class PhoneLoginScreen extends StatelessWidget {
  final phone = TextEditingController();
  final loginController = Get.put(PhoneController());

  PhoneLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: ListView(children: [
          Column(
            children: [
              Form(
                  child: Column(
                children: [
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                    ),
                  )),
                  Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 5),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              loginController.verifyPhone(phone.text);
                              Get.to(OtpScreen());
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15.0,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      "Sign In",
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                )),
                          ))),
                ],
              ))
            ],
          )
        ]));
  }
}
