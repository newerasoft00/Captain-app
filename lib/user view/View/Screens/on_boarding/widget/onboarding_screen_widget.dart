import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget(
      {super.key,
      required this.backImage,
      required this.mainImage,
      required this.title,
      required this.body});
  final String backImage;
  final String mainImage;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF005048),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                backImage,
                fit: BoxFit.fitHeight,
                height: context.height * 0.7,
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Image.asset(
                      mainImage,
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: AutoSizeText(
              title,
              softWrap: true,
              maxLines: 2,
              maxFontSize: 30,
              minFontSize: 22,
              wrapWords: true,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AutoSizeText(
              body,
              softWrap: true,
              maxFontSize: 18,
              minFontSize: 16,
              wrapWords: true,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
