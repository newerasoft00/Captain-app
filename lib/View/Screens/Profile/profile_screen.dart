import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/View/Screens/Auth/Login/login_screen.dart';
import '../../../Controller/profile_Controller.dart';
import '../../../Core/helper/shared_preference/shared_preference.dart';
import 'widget/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller =
        Get.put(ProfileController(), permanent: true);
    return RefreshIndicator(
      onRefresh: () async{
       await controller.fetchUserData('1325');
      },
      child: Center(
        child: Obx(
          () {
            final user = controller.user.value;
            if (user != null) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileListItem(
                        icon: CupertinoIcons.person, text: user.phoneNumber),
                    ProfileListItem(
                        icon: CupertinoIcons.person_crop_circle,
                        text: user.name),
                    ProfileListItem(
                        icon: CupertinoIcons.mail, text: user.email),
                    ProfileListItem(
                        icon: CupertinoIcons.phone, text: user.phone),
                    const ProfileListItem(
                        icon: CupertinoIcons.settings, text: 'Settings'),
                    ObxValue(
                      (data) => Card(
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
                                    Get.changeThemeMode(
                                      controller.isLightTheme.value
                                          ? ThemeMode.light
                                          : ThemeMode.dark,
                                    );
                                  },
                                ),
                              ],
                            )),
                      ),
                      false.obs,
                    ),
                    GestureDetector(
                        onTap: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            UserPreference.setIsLoggedIn(false);
                            UserPreference.setUserId('');
                            Get.snackbar(
                              'Success',
                              'Logged out successfully',
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 1),
                            );
                            Get.offAll(() => const LoginScreen());
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'An error occurred while signing out: $e',
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            );
                          }
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
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
