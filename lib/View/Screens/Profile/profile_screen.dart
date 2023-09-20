import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import '../../../Controller/Auth/login_controller.dart';
import '../../../Controller/profile_Controller.dart';
import '../../../Core/themes/theme_controller.dart';
import 'widget/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(
      ProfileController(),
    );
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(
      () {
        final user = controller.user;
        if (user.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileListItem(
                    icon: CupertinoIcons.person,
                    text: user[0].phoneNumber,
                  ),
                  ProfileListItem(
                    icon: CupertinoIcons.person_crop_circle,
                    text: user[0].name,
                  ),
                  ProfileListItem(
                    icon: CupertinoIcons.mail,
                    text: user[0].email,
                  ),
                  ProfileListItem(
                    icon: CupertinoIcons.phone,
                    text: user[0].phoneNumber,
                  ),
                  const ProfileListItem(
                    icon: CupertinoIcons.settings,
                    text: 'Settings',
                  ),
                  GestureDetector(
                    onTap: () {
                      themeController.toggleTheme();
                    },
                    child: SizedBox(
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
                            const Icon(
                              CupertinoIcons.moon_stars_fill,
                            ),
                            10.pw,
                            const Text(
                              'Change Theme',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.1,
                    child: GestureDetector(
                      onTap: () async {
                        final AuthController authController =
                            Get.put(AuthController());
                        authController.signout();
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            10.pw,
                            const Icon(
                              CupertinoIcons.square_arrow_left,
                              color: Colors.redAccent,
                            ),
                            10.pw,
                            const Text(
                              'Log out',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          if (user.isNotEmpty) {
            return const Center(child: Text('No Data Available'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}
