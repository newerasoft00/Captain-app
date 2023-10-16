import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Core/utils/color.dart';
import 'package:sportsbet/user%20view/Controller/todays_match_controller.dart';
import 'widget/todays_match_card.dart';

class ToDaysMatchesScreen extends StatelessWidget {
  final ToDaysMatchController controller = Get.put(ToDaysMatchController());

  ToDaysMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.todaysmatchesUCL.isNotEmpty ||
            controller.todaysmatchesPL.isNotEmpty ||
            controller.todaysmatchesRoshn.isNotEmpty ||
            controller.todaysmatchesUEL.isNotEmpty ||
            controller.todaysmatcheslaLiga.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  //   height: 110,
                  child: CalendarTimeline(
                    // shrink: true,
                    initialDate: controller.selectedDateTime,
                    firstDate: DateTime(2023, 8, 1),
                    lastDate: DateTime(2024, 6, 30),
                    dayColor: Theme.of(context).disabledColor,
                    monthColor: Theme.of(context).disabledColor,
                    showYears: false,
                    selectableDayPredicate: (date) => date.day != 32,
                    onDateSelected: (date) async {
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(date);
                      controller.selectedDateTime = date;
                      controller.currentDate.value = formattedDate;
                      controller.clearMatches();
                      controller.refeatchMatches();
                    },
                    leftMargin: 50,
                    locale: 'en_ISO',
                  ),
                ),
                15.ph,
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      // Categorize by league_name
                      final roshnMatches =
                          controller.todaysmatchesRoshn.toList();
                      final uCLMatches = controller.todaysmatchesUCL.toList();
                      final pLMatches = controller.todaysmatchesPL.toList();
                      final uELMatches = controller.todaysmatchesUEL.toList();
                      final laligaMatches =
                          controller.todaysmatcheslaLiga.toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            child: Text(
                              'ROSHN Saudi League',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                          ),
                          10.ph,
                          roshnMatches.isEmpty
                              ? const Center(child: Text('No Match ToDay'))
                              : ToDaysMatchCard(matches: roshnMatches),
                          20.ph,
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            child: Text(
                              'UEFA Champions League',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                          ),
                          10.ph,
                          uCLMatches.isEmpty
                              ? const Center(child: Text('No Match ToDay'))
                              : ToDaysMatchCard(matches: uCLMatches),
                          20.ph,
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            child: Text(
                              'English Premier League',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                          ),
                          10.ph,
                          pLMatches.isEmpty
                              ? const Center(child: Text('No Match ToDay'))
                              : ToDaysMatchCard(matches: pLMatches),
                          20.ph,
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              child: Text(
                                'UEFA Euro League',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              )),
                          uELMatches.isEmpty
                              ? const Center(child: Text('No Match ToDay'))
                              : ToDaysMatchCard(matches: uELMatches),
                          20.ph,
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              child: Text(
                                'La Liga',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              )),
                          laligaMatches.isEmpty
                              ? const Center(child: Text('No Match ToDay'))
                              : ToDaysMatchCard(matches: laligaMatches),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  //   height: 110,
                  child: CalendarTimeline(
                    // shrink: true,
                    initialDate: controller.selectedDateTime,
                    firstDate: DateTime(2023, 8, 1),
                    lastDate: DateTime(2024, 6, 30),
                    dayColor: Theme.of(context).disabledColor,
                    monthColor: Theme.of(context).disabledColor,
                    showYears: false,

                    selectableDayPredicate: (date) => date.day != 32,
                    onDateSelected: (date) async {
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(date);
                      controller.selectedDateTime = date;
                      controller.currentDate.value = formattedDate;
                      controller.clearMatches();
                      controller.refeatchMatches();
                    },
                    leftMargin: 50,
                    locale: 'en_ISO',
                  ),
                ),
                15.ph,
                StreamBuilder(
                    stream: Connectivity().onConnectivityChanged,
                    builder: (context, snapshot) {
                      return Container(
                        child: snapshot.data == ConnectivityResult.none
                            ? Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: Image.asset(
                                            'assets/Image/bro.png')),
                                    const Text('Check your internet connection')
                                  ],
                                ),
                              )
                            : const Center(child: ToDaysMatchCardShimmer()),
                      );
                    })
              ],
            ),
          );
        }
      },
    );
  }
}
