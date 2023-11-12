import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? tcolor;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.text,
    this.tcolor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              color: tcolor,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
   style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
            ),
          ),
        ],
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
