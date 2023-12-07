import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../utils/Core/themes/app_text_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onTap;
  final bool isBackButtonExist;
  const CustomAppBar({
    super.key,
    this.onTap,
    this.title,
    this.isBackButtonExist = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? '',
          style: poppinsMedium.copyWith(
              fontSize: 18, color: Theme.of(context).colorScheme.surface)),
      //centerTitle: true,
      leading: isBackButtonExist
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color:  Theme.of(context).colorScheme.surface,
              onPressed: onTap ?? ()=> Navigator.pop(context),
            )
          : const SizedBox(),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
