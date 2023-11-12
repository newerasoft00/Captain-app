import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Roshn Matches/controller/standings_controller.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StandingsController controller = Get.put(StandingsController());

    return Obx(
      () {
        if (controller.standings.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final standings = controller.standings;
          return RefreshIndicator(
            onRefresh: () => controller.updataStandings(),
            child: ListView.builder(
              itemCount: standings.length,
              itemBuilder: (context, index) {
                final standing = standings[index];
                return ListTile(
                  leading: Text('  ${standing.position}'),
                  title: Text('  ${standing.teamid}'),
                  trailing: Text('Points: ${standing.points}'),
                );
              },
            ),
          );
        }
      },
    );
  }
}
