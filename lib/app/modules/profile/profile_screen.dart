import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/profile/controller/profile_controller.dart';
import 'package:sportsbet/app/modules/profile/controller/image_picker_controller.dart';
import 'package:sportsbet/app/utils/Core/themes/app_text_theme.dart';
import 'package:sportsbet/app/widgets/custom_text.dart';
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
              ? Stack(
                  children: [
                    Obx(
                      () => Opacity(
                        opacity: 0.1,
                        child: CachedNetworkImage(
                          imageUrl: controller.selectedLeague.isNotEmpty
                              ? controller.selectedLeague.value
                              : UserPreference.getSelectedLeaguelogo(),
                          height: context.height,
                          width: context.width,
                          fit: BoxFit.fitWidth,
                          fadeInCurve: Curves.linear,
                          fadeInDuration: const Duration(milliseconds: 300),
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
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
                                    CustomText(
                                      title: user[0].name,
                                      minFontSize: 18,
                                      maxFontSize: 20,
                                      maxLine: 1,
                                      style: poppinsMedium.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CustomText(
                                      title: user[0].email,
                                      textColor: Colors.grey[600],
                                      minFontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          ProfileMenuItem(
                            icon: Icons.dashboard_rounded,
                            text: 'Favorite Team'.tr,
                            iconColor: Colors.deepOrangeAccent,
                            onTap: () {
                              controller.showLeagueBottomSheet(context);
                            },
                            trailing: Obx(
                              () => CachedNetworkImage(
                                imageUrl: controller.selectedLeague.isNotEmpty
                                    ? controller.selectedLeague.value
                                    : UserPreference.getSelectedLeaguelogo(),
                                height: 30,
                                width: 30,
                                placeholder: (context, url) => const Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
                            icon: Icons.dark_mode,
                            text: 'Change Theme'.tr,
                            iconColor: Colors.amber,
                            onTap: () => themeController.toggleTheme(0),
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
                    ),
                  ],
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
