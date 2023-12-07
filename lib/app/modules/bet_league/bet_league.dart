import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/overall_widget.dart';
import 'widget/round_widget.dart';

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
                  indicatorColor:
                      Theme.of(context).primaryColor.withOpacity(0.95),
                  dividerColor: Theme.of(context).colorScheme.secondary,
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
