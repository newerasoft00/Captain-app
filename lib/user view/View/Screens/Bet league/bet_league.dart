import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/user%20view/View/Screens/Bet%20league/widget/overall_widget.dart';
import 'package:sportsbet/user%20view/View/Screens/Bet%20league/widget/round_widget.dart';

class BetLeague extends StatelessWidget {
  const BetLeague({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text('Bet League'.tr),
                centerTitle: true,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Overall Rank'.tr,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Round Rank'.tr,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [UserAppearanceCountsPage(), RoundStandingWidget()],
          ),
        ),
      ),
    );
  }
}
