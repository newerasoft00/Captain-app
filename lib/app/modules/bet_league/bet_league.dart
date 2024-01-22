import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/utils/Core/themes/app_text_theme.dart';
import 'package:captain/app/widgets/custom_text.dart';
import '../ads/custom_ad_widget.dart';
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
                title: CustomText(
                  title: 'Bet League'.tr,
                  style: poppinsMedium.copyWith(
                      color: Theme.of(context).colorScheme.surface),
                ),
                centerTitle: true,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  indicatorColor:
                      Theme.of(context).primaryColor.withOpacity(0.95),
                  dividerColor: Theme.of(context).colorScheme.secondary,
                  tabs: [
                    Tab(
                      child: CustomText(
                        title: 'Overall Rank'.tr,
                        style: poppinsMedium.copyWith(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                    Tab(
                      child: CustomText(
                        title: 'Round Rank'.tr,
                        style: poppinsMedium.copyWith(
                            color: Theme.of(context).colorScheme.surface),
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
        bottomNavigationBar: const CustomAdBanner(),
      ),
    );
  }
}
