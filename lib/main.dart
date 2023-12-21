import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbet/app/modules/ads/ad_manager.dart';
import 'package:sportsbet/app/user_main.dart';
import 'app/firebase_options.dart';
import 'app/modules/Network/dependency_injection.dart';

SharedPreferences? sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AdMobHelper.initialization();
  DependencyInjection.init();
  runApp(UserApp());
}
