import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/profile/controller/profile_controller.dart';
import 'package:sportsbet/app/modules/profile/controller/image_picker_controller.dart';
import '../../routes/routes.dart';
import '../../translations/local_controller.dart';
import '../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../../utils/Core/themes/theme_controller.dart';
import '../auth/cotroller/login_controller.dart';
import 'widget/profile_menu_widget.dart';
import 'widget/user_pic.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    MyLocalController localController = Get.find();
    final ThemeController themeController = Get.find<ThemeController>();
    final ImagePickerController imageController = Get.find();

    Future<void> uploadImage() async {
      await imageController.pickImage();
    }

    imageController.initImage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'.tr),
        centerTitle: true,
      ),
      body: Obx(
        () {
          final user = controller.user;

          return user.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DisplayImage(
                            imagePath: imageController.imagePath.value,
                            onPressed: uploadImage,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user[0].name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  user[0].email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      ProfileMenuItem(
                        icon: Icons.dashboard_rounded,
                        text: 'Favorite League'.tr,
                        iconColor: Colors.deepOrangeAccent,
                        onTap: () {
                          controller.showLeagueBottomSheet(context);
                        },
                        trailing: Obx(
                          () => Image.asset(
                            controller.selectedLeague.isNotEmpty
                                ? controller.selectedLeague.value
                                : UserPreference.getSelectedLeaguelogo(),
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      ProfileMenuItem(
                        icon: CupertinoIcons.square_list_fill,
                        text: 'Show Bet History'.tr,
                        iconColor: Colors.deepPurple,
                        onTap: () async {
                          await controller.getUserData();
                          Get.toNamed(Routes.betHistory);
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.feedback_rounded,
                        text: 'Give Feedback'.tr,
                        iconColor: Colors.greenAccent.shade700,
                        onTap: () {
                          Get.toNamed(Routes.feedbackScreen);
                        },
                      ),
                      ProfileMenuItem(
                        icon: themeController.islightMode.value
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        text: themeController.islightMode.value
                            ? 'Light Theme'.tr
                            : 'Dark Theme'.tr,
                        iconColor: themeController.islightMode.value
                            ? Colors.amber
                            : Colors.blue,
                        onTap: themeController.toggleTheme,
                      ),
                      ProfileMenuItem(
                        icon: Icons.language_rounded,
                        text: 'Change Language'.tr,
                        iconColor: Colors.pinkAccent,
                        onTap: () {
                          localController.toggleLang();
                        },
                      ),
                      ProfileMenuItem(
                        icon: CupertinoIcons.square_arrow_left_fill,
                        text: 'Log Out'.tr,
                        iconColor: Colors.red,
                        onTap: () {
                          final AuthController authController =
                              Get.put(AuthController());
                          authController.signout();
                        },
                      ),
                    ],
                  ),
                )
              : Center(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const ProfileListItemShimmer();
                    },
                  ),
                );
        },
      ),
    );
  }
}
