import 'package:flutter/material.dart';
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
          borderRadius: BorderRadius.circular(10),
        ),
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
