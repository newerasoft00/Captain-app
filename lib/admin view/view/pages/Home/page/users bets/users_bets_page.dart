import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/admin%20view/admin%20controller/match_details.dart';
import 'package:sportsbet/admin%20view/view/pages/Home/page/users%20bets/match_bet_details.dart';

import '../../../../../admin controller/users_bet_controller.dart';

class UsersBetsPage extends StatelessWidget {
  UsersBetsPage({super.key});
  final UsersBetController betController = Get.put(UsersBetController());
  final MatchDetailsController matchDetailsController =
      Get.put(MatchDetailsController());

  @override
  Widget build(BuildContext context) {
    // Reverse the documentNames list

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () {
            final reversedDocumentNames =
                betController.documentNames.reversed.toList();

            if (reversedDocumentNames.isEmpty) {
              return const CircularProgressIndicator.adaptive();
            } else {
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  betController.bets.clear();
                },
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 5,
                        crossAxisCount: orientation == Orientation.portrait
                            ? 1
                            : 3, // Set the number of columns based on orientation
                      ),
                      itemCount: reversedDocumentNames.length,
                      itemBuilder: (context, index) {
                        final docName = reversedDocumentNames[index];

                        return Hero(
                          tag:
                              'eventID_$docName', // Make the tag unique by adding the docName
                          transitionOnUserGestures: true,
                          child: GestureDetector(
                            onTap: () async {
                              betController.homeWins.value = 0;
                              betController.awayWins.value = 0;
                              betController.drawingUsers.value = 0;
                              await betController
                                  .fetchBets(docName)
                                  .then((value) async {
                                await matchDetailsController
                                    .fetchEventData(docName);

                                await betController.calculateStatistics();
                                Get.to(() => MatchBetDetails(
                                      docName: docName,
                                    ));
                              });
                            },
                            child: SizedBox(
                              width: context.isPortrait
                                  ? context.width * 0.95
                                  : context.width * 0.45,
                              child: Card(
                                color: const Color(0xffE9DDFF),
                                elevation: 3,
                                surfaceTintColor: Colors.white,
                                child: ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'Match Id :   ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal)),
                                        TextSpan(
                                            text: docName,
                                            style: const TextStyle(
                                                color: Color(0xff6750A4),
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                  // Add more widgets or actions as needed
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
