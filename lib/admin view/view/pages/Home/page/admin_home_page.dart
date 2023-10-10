import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sportsbet/admin%20view/view/pages/Home/page/statistics%20page/statistics_page.dart';
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
      extendBody: true,
      body: Obx(() => Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            child: IndexedStack(
              index: controller.pageindex.value,
              children: bottomBarItem,
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 5,
                    offset: Offset(-1, 1),
                    color: Color.fromARGB(148, 177, 177, 177))
              ],
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              gap: 8,
              color: Colors.black, // unselected icon color
              activeColor: Colors.blue.shade900, // selected icon and text color
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              tabBackgroundColor:
                  const Color(0xffD7E3F7), // selected tab background color

              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: CupertinoIcons.house_fill,
                  text: 'Home',
                ),
                GButton(
                  icon: CupertinoIcons.square_favorites_fill,
                  text: 'User Bets',
                ),
              ],
              selectedIndex: controller.pageindex.value,
              onTabChange: (index) {
                controller.changePageIndex(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
