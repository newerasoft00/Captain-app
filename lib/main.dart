import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbet/user%20view/user_main.dart';
import 'firebase_options.dart';
import 'user view/Controller/Network/dependency_injection.dart';

SharedPreferences? sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.init();
  runApp(UserApp());
}
