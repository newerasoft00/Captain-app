import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import '../../../Controller/Auth/login_controller.dart';
import '../../../Controller/profile_Controller.dart';
import 'widget/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(
      ProfileController(),
    );
    return Center(
      child: Obx(
        () {
          final user = controller.user;
          if (user.isNotEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProfileListItem(
                    icon: CupertinoIcons.person,
                    text: controller.userPhoneNumber,
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
                  ObxValue(
                    (data) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                controller.isLightTheme.value
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                              ),
                              10.pw,
                              Text(
                                controller.isLightTheme.value
                                    ? 'light_mode'
                                    : 'Dark Mode',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              CupertinoSwitch(
                                activeColor: Colors.blueAccent,
                                trackColor: CupertinoColors.inactiveGray,
                                thumbColor: CupertinoColors.white,
                                value: controller.isLightTheme.value,
                                onChanged: (val) {
                                  controller.isLightTheme.value = val;
                                  controller.isLightTheme.value
                                      ? Get.changeThemeMode(ThemeMode.light)
                                      : Get.changeThemeMode(ThemeMode.dark);
                                },
                              ),
                            ],
                          )),
                    ),
                    false.obs,
                  ),
                  GestureDetector(
                      onTap: () async {
                        final AuthController authController =
                            Get.put(AuthController());
                        authController.signout();
                      },
                      child: const ProfileListItem(
                        icon: CupertinoIcons.square_arrow_left,
                        text: 'Logout',
                        tcolor: Colors.redAccent,
                      )),
                ],
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
      ),
    );
  }
}
