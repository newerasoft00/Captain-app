import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.imagePath, this.sizeW, this.sizeH});
  final String? imagePath;
  final double? sizeW;
  final double? sizeH;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeW ?? context.width * 0.3,
      height:sizeH?? context.height * 0.1,
      child: Lottie.asset(imagePath ?? 'assets/Image/roshan_loader.json'),
    );
  }
}
