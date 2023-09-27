import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onPressed,
      child: Center(
          child: SizedBox(
        width: 120,
        height: 120,
        child: Stack(children: [
          buildImage(color),
          Positioned(
            right: 4,
            bottom: 10,
            child: buildEditIcon(color),
          )
        ]),
      )),
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    return CachedNetworkImage(
        imageUrl: imagePath,
        key: UniqueKey(),
        placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
        errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.error,
                size: 50,
                color: Colors.redAccent,
              ),
            ),
        imageBuilder: (context, imageProvider) {
          // you can access to imageProvider
          return CircleAvatar(
            radius: 60,
            backgroundImage: imageProvider,
          );
        });
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
