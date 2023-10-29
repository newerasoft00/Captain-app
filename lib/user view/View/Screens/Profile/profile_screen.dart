import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/Local/local_controller.dart';
import 'package:sportsbet/User%20View/Controller/image_picker_controller.dart';
import 'package:sportsbet/user%20view/Controller/Auth/login_controller.dart';
import 'package:sportsbet/user%20view/Controller/profile_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Profile/user_bet_history_screen.dart';

import '../../../../Core/routes/routes.dart';
import '../../../../Core/themes/theme_controller.dart';
import 'widget/profile_menu_widget.dart';
import 'widget/user_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(
      ProfileController(),
    );
    MyLocalController localController = Get.find();
    final ThemeController themeController = Get.find<ThemeController>();

    // final ThemeController themeController = Get.put(ThemeController());
    final ImagePickerController imageController =
        Get.put(ImagePickerController());

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
          if (user.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      DisplayImage(
                          imagePath: imageController.imagePath.value,
                          onPressed: uploadImage),
                      10.pw,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user[0].name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            user[0].email,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                  const Spacer(
                    flex: 1,
                  ),
                  user[0].phoneNumber.isPhoneNumber
                      ? ProfileListItem(
                          icon: Icons.phone_android_rounded,
                          text: user[0].phoneNumber,
                          tcolor: Colors.amber.shade800,
                        )
                      : const SizedBox(),
                  const Spacer(
                    flex: 1,
                  ),
                  GestureDetector(
                      onTap: () {
                        // Show the bottom sheet when "Settings" is tapped
                        controller.showLeagueBottomSheet(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.dashboard_rounded,
                                  color: Color(0xffEA1A8E),
                                )),
                            Expanded(
                                flex: 6,
                                child: Text(
                                  'Favorite League'.tr,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
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
                          ],
                        ),
                      )),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => UserBetHistoryScreen());
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return AlertDialog(
                        //       title: Center(child: Text('Your Bet History'.tr)),
                        //       content: SizedBox(
                        //         width: context.width * 0.8, // Specify a width
                        //         height:
                        //             context.height * 0.3, // Specify a height
                        //         child: BetHistoryWidget(),
                        //       ),
                        //       actions: [
                        //         Center(
                        //           child: TextButton(
                        //               onPressed: () {
                        //                 Navigator.of(context).pop();
                        //               },
                        //               child: Text('Close'.tr)),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Icon(
                              CupertinoIcons.square_list_fill,
                              color: Color(0xff7153FF),
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: Text(
                                'Show Bet History'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.feedbackScreen);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.feedback_rounded,
                              color: Color(0xffFFB400),
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: AutoSizeText(
                                'Give a feedback'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Obx(() => GestureDetector(
                        onTap: themeController.toggleTheme,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(
                                themeController.islightMode.value
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                                color: themeController.islightMode.value
                                    ? Colors.amber.shade900
                                    : Colors.amberAccent,
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Text(
                                themeController.islightMode.value
                                    ? 'Light Theme'.tr
                                    : 'Dark Theme'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  const Spacer(
                    flex: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      localController.toggleLang();
                    },
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                width: 27,
                                height: 27,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    Image.asset('assets/Image/language.png'))),
                        Expanded(
                          flex: 7,
                          child: Text(
                            'Change Language'.tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  SizedBox(
                    width: Get.width,
                    child: GestureDetector(
                      onTap: () async {
                        final AuthController authController =
                            Get.put(AuthController());
                        authController.signout();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Icon(
                              CupertinoIcons.square_arrow_left_fill,
                              color: Color(0xfff75555),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              'Log out'.tr,
                              style: const TextStyle(
                                color: Color(0xfff75555),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  )
                ],
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
      ),
    );
  }
}
