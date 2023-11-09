import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/res/i_font_res.dart';

import '../../../../../Model/match Day Models/todays_matches.dart';

class ToDaysMatchCard extends StatelessWidget {
  final List<ToDaysMatch> matches;

  const ToDaysMatchCard({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final categorizedMatch = matches[index];
          return SizedBox(
            width: Get.width * 0.8,
            height: Get.width * 0.4,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: categorizedMatch.awayTeamLogo == ''
                              ? Image.asset('assets/Image/def_logo.jpg')
                              : Image.network(
                                  categorizedMatch.homeTeamLogo,
                                  fit: BoxFit.contain,
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                        6.ph,
                        FittedBox(
                          child: Text(
                            categorizedMatch.eventHomeTeam,
                            style: const TextStyle(
                              fontFamily: FontRes.TAJAWAL_MEDIUM,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            categorizedMatch.eventDate,
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: FontRes.TAJAWAL_MEDIUM,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        /*  FittedBox(
                          child: Text(
                            categorizedMatch.eventLive != '0'
                                ? categorizedMatch.eventLive
                                : categorizedMatch.eventTime,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: FontRes.TAJAWAL_MEDIUM,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ), */
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categorizedMatch.eventLive == '0'
                                  ? categorizedMatch.eventTime
                                  : categorizedMatch.eventTime,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: FontRes.TAJAWAL_MEDIUM,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: categorizedMatch.awayTeamLogo == ''
                              ? Image.asset('assets/Image/def_logo.jpg')
                              : Image.network(
                                  categorizedMatch.awayTeamLogo,
                                  fit: BoxFit.contain,
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                        6.ph,
                        FittedBox(
                          child: Text(
                            categorizedMatch.eventAwayTeam,
                            maxLines: 2,
                            style: const TextStyle(
                              fontFamily: FontRes.TAJAWAL_MEDIUM,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ToDaysMatchCardShimmer extends StatelessWidget {
  const ToDaysMatchCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.5,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Change to your preferred base color
        highlightColor:
            Colors.grey[100]!, // Change to your preferred highlight color
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 3, // Adjust the number of shimmer items as needed
          itemBuilder: (context, index) {
            return SizedBox(
              width: Get.width * 0.8,
              height: Get.width * 0.4,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.white, // Adjust the background color
                          ),
                          6.ph,
                          Container(
                            width: 100, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                            color: Colors.white, // Adjust the background color
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                            color: Colors.white, // Adjust the background color
                          ),
                          6.ph,
                          Container(
                            width: 100, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                            color: Colors.white, // Adjust the background color
                          ),
                          Container(
                            width: 100, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                            color: Colors.white, // Adjust the background color
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.white, // Adjust the background color
                          ),
                          6.ph,
                          Container(
                            width: 100, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                            color: Colors.white, // Adjust the background color
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
