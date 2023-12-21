import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'translations/local.dart';
import 'translations/local_controller.dart';
import 'utils/Core/helper/shared_preference/shared_preference.dart';
import 'routes/routes.dart';
import 'utils/Core/themes/theme_controller.dart';

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
      darkTheme: themeController.themes[themeController.selectedThemeIndex.value],
      theme: themeController.themes[themeController.selectedThemeIndex.value],
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
      initialRoute:
          UserPreference.isLoggedIn() ? Routes.homeScreen : Routes.loginscreen,
    );
  }
}
