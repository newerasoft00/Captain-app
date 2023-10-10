import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

class CustomContainer extends StatelessWidget {
  final Color color;
  final String title;
  final String body;
  final String status;
  const CustomContainer(
      {super.key,
      required this.color,
      required this.title,
      required this.body,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: context.isPortrait ? context.width * 0.9 : context.width * 0.42,
        child: Card(
          color: color,
          elevation: 3,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(title),
                20.ph,
                Text(body),
                10.ph,
                Text(status),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
