import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onPressed,
      child: Center(
          child: SizedBox(
        width: 65,
        height: 65,
        child: buildImage(color),
      )),
    );
  }

  Widget buildImage(Color color) {
    return CachedNetworkImage(
        imageUrl: imagePath,
        key: UniqueKey(),
        placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
        errorWidget: (context, url, error) => const Center(
              child: Icon(
                CupertinoIcons.person_add_solid,
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
