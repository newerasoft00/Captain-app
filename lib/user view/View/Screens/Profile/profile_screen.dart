import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/User%20View/Controller/image_picker_controller.dart';
import 'package:sportsbet/user%20view/Controller/Auth/login_controller.dart';
import 'package:sportsbet/user%20view/Controller/profile_controller.dart';
import '../../../../../Core/themes/theme_controller.dart';
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
    // final ThemeController themeController = Get.put(ThemeController());
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
              primary: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  20.ph,
                  DisplayImage(
                      imagePath: imageController.imagePath.value,
                      onPressed: uploadImage),
                  15.ph,
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
                  GestureDetector(
                      onTap: () {
                        // Show the bottom sheet when "Settings" is tapped
                        controller.showLeagueBottomSheet(context);
                      },
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Obx(
                                  () => Image.asset(
                                    controller.selectedLeague.isNotEmpty
                                        ? controller.selectedLeague.value
                                        : UserPreference
                                            .getSelectedLeaguelogo(),
                                    width: 30,
                                    height: 30,
                                  ),
                                )),
                            const Expanded(
                                flex: 5, child: Text('Favorite League')),
                          ],
                        ),
                      ))),
                  5.ph,
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  const Center(child: Text('Your Bet History')),
                              content: SizedBox(
                                width: context.width * 0.8, // Specify a width
                                height:
                                    context.height * 0.3, // Specify a height
                                child: BetHistoryWidget(),
                              ),
                              actions: [
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.receipt_rounded,
                            color: Colors.greenAccent,
                          ),
                          20.pw,
                          const Text('Show Bet History'),
                        ],
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
                            20.pw,
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
                  40.ph
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
