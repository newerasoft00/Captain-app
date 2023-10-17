import 'package:flutter/material.dart';
import '../../../../Model/match Day Models/match_day.dart';
import 'widget/team_info.dart';


class MatchDetailsScreen extends StatelessWidget {
  final MatchDay match;

  const MatchDetailsScreen({Key? key, required this.match}) : super(key: key);

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
