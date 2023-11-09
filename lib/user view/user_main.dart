import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/user%20view/Screens/Auth/Login/login_screen.dart';
import 'package:sportsbet/user%20view/Screens/Home/home_screen.dart';

import '../Core/routes/routes.dart';
import '../Core/themes/dark_light_theme_file.dart';
import '../Core/themes/theme_controller.dart';
import '../Local/local.dart';
import '../Local/local_controller.dart';

class UserApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  UserApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locaController = Get.put(MyLocalController());
    final localeValue = locaController.selectedLang.value;
    final locale = (localeValue == 'en' || localeValue == 'ar')
        ? Locale(localeValue)
        : const Locale('en');

    return GetMaterialApp(
      navigatorKey: Get.key,
      theme: light,
      darkTheme: dark,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      title: 'Roshan Bet',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
      locale: locale,
      translations: MyLocal(),
      getPages: Routes.getPages,
      home: UserPreference.isLoggedIn()
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
