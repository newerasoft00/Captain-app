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
      color: const Color(0xff010723),
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
                  child: Image.asset(mainImage)),
            ],
          ),
          Text(
            title,
            softWrap: true,
            maxLines: 1,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700,color: Colors.white),
          ),
          Text(
            body,
            softWrap: true,
            maxLines: 1,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
