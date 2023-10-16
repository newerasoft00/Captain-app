import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbet/admin%20view/admin_main.dart';

import 'user view/Controller/Network/dependency_injection.dart';

SharedPreferences? sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  DependencyInjection.init();
  runApp(AdminDashboard());
}
