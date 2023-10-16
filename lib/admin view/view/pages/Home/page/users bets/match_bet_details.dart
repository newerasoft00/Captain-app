import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/admin%20view/admin%20controller/match_details.dart';
import 'package:sportsbet/admin%20view/view/pages/Home/page/winner.dart/winner_page.dart';

import '../../../../../admin controller/users_bet_controller.dart';
import 'user_bet_details.dart';

class MatchBetDetails extends StatelessWidget {
  const MatchBetDetails({super.key, required this.docName});
  final String docName;

  @override
  Widget build(BuildContext context) {
    final UsersBetController betController = Get.put(UsersBetController());
    MatchDetailsController matchDetailsController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6750A4),
        leading: IconButton(
            onPressed: () {
              betController.onClose();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: context.height,
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 10,
              crossAxisAlignment: context.isLandscape
                  ? WrapCrossAlignment.center
                  : WrapCrossAlignment.start,
              children: [
                Hero(
                  tag:
                      'eventID_$docName', // Make the tag unique by adding the docName
                  transitionOnUserGestures: true,
                  child: SizedBox(
                    width: context.isPortrait
                        ? context.width * 0.94
                        : context.width * 0.45,
                    height: context.isPortrait
                        ? context.height * 0.10
                        : context.height * 0.15,
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      surfaceTintColor: Colors.white,
                      child: ListTile(
                        title: Wrap(
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.spaceEvenly,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              height: context.isPortrait
                                  ? context.height * 0.07
                                  : context.height * 0.10,
                              child: Image.network(
                                matchDetailsController.homeTeamLogoUrl.value,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Text(matchDetailsController.homeTeamName.value),
                            const Text('   vs   '),
                            Text(matchDetailsController.awayTeamName.value),
                            SizedBox(
                              height: context.isPortrait
                                  ? context.height * 0.07
                                  : context.height * 0.10,
                              child: Image.network(
                                matchDetailsController.awayTeamLogoUrl.value,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  child: UserBetDetails(),
                ),
                10.ph,
                SizedBox(
                  width: double.infinity,
                  height: context.isPortrait
                      ? context.height * 0.46
                      : context.height * 0.40,
                  child: ListView.builder(
                      itemCount: betController.bets.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final bet = betController.bets[index];
                        return Card(
                          color: Colors.white,
                          elevation: 3,
                          surfaceTintColor: Colors.white,
                          child: ListTile(
                            title: Text('UserID: ${bet['userID']}'),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Win Team :  ${bet['winTeam']}',
                                  style: const TextStyle(
                                      color: Color(0xffBB2525),
                                      fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                Text(
                                  '${bet['winScore']} : ${bet['loseScore']}',
                                  style: TextStyle(
                                      color: Colors.lightGreen.shade900,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),

                            // Add more widgets to display other data fields
                          ),
                        );
                      }),
                ),
                30.ph,
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: GetPlatform.isIOS
                          ? CupertinoButton.filled(
                              onPressed: () {
                                betController.spinthwheel();
                                Get.to(() => WinnerPage(docName: docName));
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: const Text(
                                'see winners',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                MatchDetailsController matchDetailsController =
                                    Get.put(MatchDetailsController());
                                await matchDetailsController
                                    .fetchH2H(
                                        matchDetailsController
                                            .homeTeamKey.value,
                                        matchDetailsController
                                            .awayTeamKey.value)
                                    .then((value) => Get.to(
                                        () => WinnerPage(docName: docName)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff6750A4),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                'see winners',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
