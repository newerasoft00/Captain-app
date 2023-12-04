import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/profile_controller.dart';
import 'controller/user_bet_history_controller.dart';

class UserBetHistoryScreen extends StatelessWidget {
  final UserBetHistoryController _controller =
      Get.find();
  final ProfileController pc = Get.find();
  UserBetHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bet History'),
      ),
      body: Obx(
        () => _controller.betHistory.isEmpty
            ? const Center(
                child: Text('No bet history available.'),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        height: context.height * 0.2,
                        child: Center(
                            child: AutoSizeText(
                          'Total Bet Point : ${pc.userinformation!.totalBetPoint.toString()}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.onPrimary),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      height: context.height * 0.9,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          pc.getUserData();
                          pc.fetchBetHistoryData();
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: true,
                          itemCount: _controller.betHistory.length,
                          itemBuilder: (context, index) {
                            // _roshnMatchController.fetchData();
                            final bets = _controller.betHistory[index];
                            return Card(
                              elevation: 0,
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.17),
                              child: ListTile(
                                leading: Text('${index + 1}'),
                                title: Text(bets['teams'].toString()),
                                trailing: Text(bets['match_score'].toString()),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
