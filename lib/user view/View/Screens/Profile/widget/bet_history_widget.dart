import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/user%20view/Controller/user_bet_history_controller.dart';

class BetHistoryWidget extends StatelessWidget {
  final UserBetHistoryController controller =
      Get.put(UserBetHistoryController());

  BetHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.hasError.value) {
        return const SizedBox();
      } else if (controller.betHistory.isEmpty) {
        return const SizedBox();
      } else {
        // Display the bet history data
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.betHistory.length,
          itemBuilder: (context, index) {
            int reversedIndex = controller.betHistory.length - 1 - index;

            final betData = controller.betHistory[reversedIndex];
            return ListTile(
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Match Date '),
                  Text('${betData['match_Date']}'),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' ${betData['teams']}'),
                  Text(' ${betData['user_bet']}'),
                ],
              ),
            );
          },
        );
      }
    });
  }
}
