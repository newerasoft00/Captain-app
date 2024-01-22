import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.3,
      height: context.height * 0.1,
      child: Lottie.asset('assets/Image/roshan_loader.json'),
    );
  }
}
