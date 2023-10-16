import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/admin%20view/view/pages/Home/page/admin_home_page.dart';
import 'package:sportsbet/admin%20view/view/pages/Login/login_page.dart';
import 'package:sportsbet/res/i_font_res.dart';

import '../Core/themes/theme_controller.dart';

class AdminDashboard extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  AdminDashboard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      title: 'Admin Dashboard',
      themeMode: ThemeMode.light,
      theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff6750A4),
              surfaceTintColor: Color.fromARGB(0, 244, 244, 249)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: const Color(0xffF4F4F9),
          useMaterial3: true,
          fontFamily: FontRes.TAJAWAL_MEDIUM),
      home: UserPreference.isLoggedIn()
          ? const AdminHomePage()
          : const LoginPage(),
    );
  }
}
