import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? tcolor;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.tcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.1,
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.pw,
            Icon(
              icon,
            ),
            10.pw,
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
