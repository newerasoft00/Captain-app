import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

import '../../../../../admin controller/match_details.dart';
import '../../../../../admin controller/users_bet_controller.dart';

class WinnerPage extends StatelessWidget {
  const WinnerPage({super.key, required this.docName});
  final String docName;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBets = [];
    MatchDetailsController matchDetailsController = Get.find();
    final UsersBetController betController = Get.put(UsersBetController());
    int homeScore = int.parse(matchDetailsController.matches[0].eventFinalResult
        .split('-')[0]
        .trim());
    int awayScore = int.parse(matchDetailsController.matches[0].eventFinalResult
        .split('-')[1]
        .trim());
    final winTeam = (homeScore > awayScore)
        ? matchDetailsController.matches[0].eventHomeTeam
        : (homeScore == awayScore)
            ? 'Drawing'
            : matchDetailsController.matches[0].eventAwayTeam;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      FittedBox(
                          child: Text(
                        matchDetailsController.homeTeamName.value,
                      )),
                      FittedBox(
                          child: Text(
                        ' ${matchDetailsController.matches[0].eventFinalResult} ',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      )),
                      FittedBox(
                          child:
                              Text(matchDetailsController.awayTeamName.value)),
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
          SizedBox(
              width: double.infinity,
              height: context.isPortrait
                  ? context.height * 0.35
                  : context.height * 0.40,
              child: Obx(
                () => ListView.builder(
                    itemCount: betController.bets.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final bet = betController.bets[index];
                      return (((bet['winTeam'] == winTeam) &&
                              (matchDetailsController
                                      .matches[0].eventFinalResult
                                      .toString() ==
                                  '${bet['winScore']} - ${bet['loseScore']}')))
                          ? Column(
                              children: [
                                35.ph,
                                SizedBox(
                                  width: 250.0,
                                  height: context.height * 0.03,
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      RotateAnimatedText('the winner is',
                                          textStyle: TextStyle(
                                              fontFamily: 'Tajawal-Medium',
                                              color: Colors.green.shade700,
                                              fontWeight: FontWeight.w800)),
                                      RotateAnimatedText('${bet['userID']}',
                                          textStyle: TextStyle(
                                              fontFamily: 'Tajawal-Medium',
                                              color: Colors.green.shade700,
                                              fontWeight: FontWeight.w800)),
                                    ],
                                    isRepeatingAnimation: true,
                                  ),
                                ),
                                20.ph,
                                Card(
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
                                ),
                              ],
                            )
                          : const SizedBox();
                    }),
              )),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1)
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Enter an integer',
                          contentPadding: EdgeInsets.all(12.0),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          // Handle the input value here
                          int? enteredValue = int.tryParse(text);
                          if (enteredValue != null) {
                            // Do something with the entered integer
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: GetPlatform.isIOS
                      ? CupertinoButton.filled(
                          onPressed: () {
                            filteredBets = betController.bets.where((bet) {
                              return (bet['winTeam'] == winTeam) &&
                                  (matchDetailsController
                                          .matches[0].eventFinalResult ==
                                      '${bet['winScore']} - ${bet['loseScore']}');
                            }).toList();

                            if (filteredBets.isNotEmpty) {
                              // Choose a random winner
                              Random random = Random();
                              int randomIndex =
                                  random.nextInt(filteredBets.length);
                              Map<String, dynamic> randomWinner =
                                  filteredBets[randomIndex];

                              // Display the random winner
                              showRandomWinner(
                                  randomWinner['userID'],
                                  betController.user[0].name,
                                  betController
                                          .user[0].phoneNumber.isPhoneNumber
                                      ? betController.user[0].phoneNumber
                                      : betController.user[0].email,
                                  context);
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: const Text(
                            'chose winners',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            filteredBets = betController.bets.where((bet) {
                              return (bet['winTeam'] == winTeam) &&
                                  (matchDetailsController
                                          .matches[0].eventFinalResult ==
                                      '${bet['winScore']} - ${bet['loseScore']}');
                            }).toList();

                            if (filteredBets.isNotEmpty) {
                              // Choose a random winner
                              Random random = Random();
                              int randomIndex =
                                  random.nextInt(filteredBets.length);
                              Map<String, dynamic> randomWinner =
                                  filteredBets[randomIndex];
                              await betController
                                  .getUserData(randomWinner['userID'])
                                  .then((value) {
                                showRandomWinner(
                                    randomWinner['userID'],
                                    betController.user[0].name,
                                    betController
                                            .user[0].phoneNumber.isPhoneNumber
                                        ? betController.user[0].phoneNumber
                                        : betController.user[0].email,
                                    context);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6750A4),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            'Chose winner',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showRandomWinner(String winner, String name, String phone, context) {
    // Show the random winner in a dialog or another UI element.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: const Text('the chosen Winner')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(winner),
              Text('Name : $name'),
              Text('Contact : $phone'),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6750A4),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FilledButton.icon(
                    onPressed: () async {
                      if (winner.isNum) {
                        await FlutterPhoneDirectCaller.callNumber(winner);
                      } else {
                        Get.back();
                        Get.snackbar('info',
                            'invalid phone number\nemail saved to  clipboard');
                        await Future.delayed(const Duration(seconds: 2));
                      }
                      // Uri url = Uri(scheme: "tel", path: phone);
                      // if (await canLaunchUrl(url)) {
                      //   await launchUrl(url);
                      // } else {
                      //   print("Can't open dial pad.");
                      // }
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('Call'))
              ],
            )
          ],
        );
      },
    );
  }
}
