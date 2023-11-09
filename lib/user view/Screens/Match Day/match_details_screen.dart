import 'package:flutter/material.dart';
import 'package:sportsbet/user%20view/View/Screens/Match%20Day/widget/team_info.dart';
import '../../../Model/match Day Models/match_day.dart';


class MatchDetailsScreen extends StatelessWidget {
  final MatchDay match;

  const MatchDetailsScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Details'),
      ),
      body: Center(
        child: buildMatchInfo(match),
      ),
    );
  }

  
}
