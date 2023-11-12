import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCardButton extends StatelessWidget {
  const CustomCardButton({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
  });
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: AnimatedContainer(
          curve: Curves.bounceInOut,
          width: width,
          height: height,
          duration: const Duration(milliseconds: 500),
          child:  Center(
              child: AutoSizeText(
            'GOALS'.tr,
            wrapWords: true,
            maxLines: 1,
            minFontSize: 16,
            maxFontSize: 18,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 2),
          )),
        ),
      ),
    );
  }
}
