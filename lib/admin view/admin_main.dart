import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/admin%20view/view/pages/Home/page/admin_home_page.dart';
import 'package:sportsbet/admin%20view/view/pages/Login/login_page.dart';
import 'package:sportsbet/res/i_font_res.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
          cardColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffF4F4F9),
              surfaceTintColor: Color.fromARGB(0, 244, 244, 249)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: const Color(0xffF4F4F9),
          useMaterial3: true,
          fontFamily: FontRes.TAJAWAL_MEDIUM),
      home: UserPreference.isLoggedIn()
          ? const AdminHomePage()
          : const LoginPage(),
    );
  }
}
