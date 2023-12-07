import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final VoidCallback onTap;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.text,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: trailing ?? Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileListItemShimmer extends StatelessWidget {
  const ProfileListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.1,
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!, // Change to your preferred base color
          highlightColor:
              Colors.grey[100]!, // Change to your preferred highlight color
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.pw,
              Container(
                width: 24,
                height: 24,
                color: Colors.white, // Adjust the color as needed
              ),
              10.pw,
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white, // Adjust the color as needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
