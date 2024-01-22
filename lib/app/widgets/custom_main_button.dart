import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/utils/Core/themes/app_text_theme.dart';

class CustomMainButton extends StatelessWidget {
  const CustomMainButton({
    super.key,
    this.buttonLabel = '',
    this.onTap,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });

  final String buttonLabel;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? context.width,
        height: height ?? context.height * 0.065,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(1.00, -0.03),
            end: const Alignment(-1, 0.03),
            colors: [
              color ?? Theme.of(context).colorScheme.secondary,
              color ?? Theme.of(context).colorScheme.secondary,
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
        child: Center(
          child: AutoSizeText(
            buttonLabel,
            style: poppinsMedium.copyWith(
                color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }
}
