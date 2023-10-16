import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/admin%20view/view/pages/Home/page/statistics%20page/statistics_page.dart';
import 'package:sportsbet/admin%20view/view/pages/Login/login_page.dart';

import '../../../../../user view/Controller/home_controller.dart';
import 'users bets/users_bets_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final bottomBarItem = [
      const Statisticspage(),
      UsersBetsPage(),
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff6750A4),
          actions: [
            IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(const LoginPage());
                },
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.redAccent,
                ))
          ],
        ),
        body: Obx(() => Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 10, left: 10, right: 10),
              child: IndexedStack(
                index: controller.pageindex.value,
                children: bottomBarItem,
              ),
            )),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              elevation: 8,
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color(0xffE9DDFF),
              backgroundColor: const Color(0xff6750A4),
              selectedLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              showUnselectedLabels: true,
              currentIndex: controller.pageindex.value,
              onTap: (index) {
                controller.changePageIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.house_alt_fill),
                  label: 'Home'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.square_list_fill),
                  label: 'User bets'.tr,
                ),
              ],
            )));
  }
}
