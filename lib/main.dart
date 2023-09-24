import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';
import 'Core/themes/dark_light_theme_file.dart';
import 'Core/themes/theme_controller.dart';
import 'View/Screens/Auth/Login/login_screen.dart';
import 'View/Screens/Auth/phone.dart';

SharedPreferences? sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      theme: light,
      darkTheme: dark,
      themeMode:
          themeController.islightMode.value ? ThemeMode.light : ThemeMode.dark,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      title: 'Roshn Bet',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      locale: const Locale('de', 'DE'),
      home: UserPreference.isLoggedIn()
          ?  PhoneLoginScreen()
          :  PhoneLoginScreen(),
    );
  }
}
