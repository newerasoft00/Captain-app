import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Model/match%20Day%20Models/match_day.dart';
import 'package:sportsbet/Model/match%20Day%20Models/match_result.dart'; // Import MatchResult
import 'package:sportsbet/Services/Api/match_day_service.dart';
import 'package:intl/intl.dart';
import 'package:sportsbet/View/Screens/Match%20Day/MatchDetailsScreen%20.dart';

import '../../../Model/match Day Models/team_info.dart';

class MatchScreen extends StatelessWidget {
  final MatchDayService matchController = Get.put(MatchDayService());

  MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown button for selecting match day
        // ... (dropdown code here)
        Expanded(
          child: Obx(
            () {
              if (matchController.matches.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: matchController.matches.length,
                  itemBuilder: (context, index) {
                    final MatchDay match = matchController.matches[index];
                    return GestureDetector(
                        onTap: () {
                          Get.to(MatchDetailsScreen(match: match));
                        },
                        child: _buildMatchInfo(match));
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatchInfo(MatchDay match) {
    final isDarkMode = Get.isDarkMode;
    return GestureDetector(
      onTap: () {
        Get.to(
            MatchDetailsScreen(match: match)); // Navigate to MatchDetailsScreen
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? const Color.fromARGB(255, 63, 63, 63)
                  : const Color(0xFFd9d9d9),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            8.ph,
            Text(
              match.matchDateTime,
              style: const TextStyle(fontSize: 14),
            ),
            8.ph,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTeamInfo(match.team1),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          '${match.scoreTeam1} : ${match.scoreTeam2}',
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _buildTeamInfo(match.team2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo(
    Team team,
  ) {
    if (team.teamIconUrl.endsWith('.svg')) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.network(
            team.teamIconUrl,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 8),
          Text(
            team.shortName,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            team.teamIconUrl,
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 8),
          Text(
            team.shortName,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
    }
  }
}
