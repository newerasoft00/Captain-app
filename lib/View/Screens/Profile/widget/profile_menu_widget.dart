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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.black
                : Colors.white, // Set the background color to white
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Get.isDarkMode
                    ? const Color.fromARGB(255, 63, 63, 63)
                    : const Color(0xFFd9d9d9),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Row(
          children: [
            Icon(
              icon,
              color: tcolor,
            ),
            10.pw,
            Text(
              text,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: tcolor),
            ),
          ],
        ),
      ),
    );
  }
}
