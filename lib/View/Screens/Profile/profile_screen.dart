import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import '../../../Controller/Auth/login_controller.dart';
import '../../../Controller/image_picker_controller.dart';
import '../../../Controller/profile_Controller.dart';
import '../../../Core/themes/theme_controller.dart';
import 'widget/bet_history_widget.dart';
import 'widget/profile_menu_widget.dart';
import 'widget/user_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(
      ProfileController(),
    );
    final ThemeController themeController = Get.put(ThemeController());
    final ImagePickerController imageController =
        Get.put(ImagePickerController());

    Future<void> uploadImage() async {
      await imageController.pickImage();
    }

    imageController.initImage();

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
                  25.ph,
                  DisplayImage(
                      imagePath: imageController.imagePath.value,
                      onPressed: uploadImage),
                  20.ph,
                  user[0].phoneNumber.isPhoneNumber
                      ? ProfileListItem(
                          icon: CupertinoIcons.person_alt_circle_fill,
                          text: user[0].phoneNumber,
                          tcolor: Colors.blue,
                        )
                      : const SizedBox(),
                  ProfileListItem(
                    icon: CupertinoIcons.person_crop_circle,
                    text: user[0].name,
                    tcolor: Colors.blue,
                  ),
                  ProfileListItem(
                    icon: CupertinoIcons.mail_solid,
                    text: user[0].email,
                    tcolor: Colors.blue,
                  ),
                  user[0].phoneNumber.isPhoneNumber
                      ? ProfileListItem(
                          icon: CupertinoIcons.phone,
                          text: user[0].phoneNumber,
                          tcolor: Colors.blue,
                        )
                      : const SizedBox(),
                  /*  const ProfileListItem(
                    icon: CupertinoIcons.settings,
                    text: 'Settings',
                  ), */
                  GestureDetector(
                    onTap: () async {
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
                              color: Colors.blue,
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
                  SizedBox(child: BetHistoryWidget()),
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
          return Center(
              child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return const ProfileListItemShimmer();
            },
          ));
        }
      },
    );
  }
}
