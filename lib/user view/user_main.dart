import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/Local/local.dart';
import 'package:sportsbet/Local/local_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Auth/Login/login_screen.dart';

import '../Core/routes/routes.dart';
import '../Core/themes/dark_light_theme_file.dart';
import '../Core/themes/theme_controller.dart';
import 'View/Screens/Home/home_screen.dart';

class UserApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  UserApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locaController = Get.put(MyLocalController());
    return GetMaterialApp(
        navigatorKey: Get.key,
        theme: light,
        darkTheme: dark,
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        debugShowCheckedModeBanner: false,
        title: 'Roshan Bet',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
        locale: Locale(locaController.selectedLang.value),
        translations: MyLocal(),
        getPages: Routes.getPages,
        home: UserPreference.isLoggedIn()
            ? const HomeScreen()
            : const LoginScreen());
  }
}
