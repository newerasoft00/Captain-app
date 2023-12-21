import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../utils/Core/themes/app_text_theme.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.title,
      this.wrapWords = true,
      this.maxFontSize = 16,
      this.minFontSize = 16,
      this.overflow = TextOverflow.ellipsis,
      this.style,
      this.maxLine = 1,
      this.textColor,
      this.isBlack = true});

  final String title;
  final bool wrapWords;
  final bool isBlack;
  final double maxFontSize;
  final double minFontSize;
  final TextOverflow overflow;
  final TextStyle? style;
  final Color? textColor;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      wrapWords: wrapWords,
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
      maxLines: maxLine,
      overflow: overflow,
      style: style ??
          poppinsMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: isBlack
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.surface),
    );
  }
}
