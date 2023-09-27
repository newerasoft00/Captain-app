import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/user_bet_history_controller.dart';

class MatchHistoryPage extends StatelessWidget {
  const MatchHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserBetHistoryController controller =
        Get.put(UserBetHistoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match History'),
      ),
      body: Obx(
        () {
          if (controller.betHistory.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: controller.betHistory.length,
              itemBuilder: (context, index) {
                final betData = controller.betHistory[index];
                return ListTile(
                  title: Text('Match ID: ${betData['match_Id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Match Date: ${betData['match_Date']}'),
                      Text('Teams: ${betData['teams']}'),
                      Text('User Bet: ${betData['user_bet']}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
