import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../Model/match Day Models/match_day.dart';
import '../../../../../Model/match Day Models/team_info.dart';

  Widget buildMatchInfo(MatchDay match) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            match.leagueName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            match.matchDateTime,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTeamInfo(match.team1),
              buildTeamInfo(match.team2),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget buildTeamInfo(Team team) {
    if (team.teamIconUrl.endsWith('.svg')) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.network(
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
