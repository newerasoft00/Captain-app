import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'match_details.dart';

class UsersBetController extends GetxController {
  final CollectionReference userBetCollection =
      FirebaseFirestore.instance.collection("User'sBet");
  final MatchDetailsController matchDetailsController =
      Get.put(MatchDetailsController());
  RxList<Map<String, String>> bets = RxList<Map<String, String>>();
  RxInt betsLength = 0.obs;
  RxInt totalDocumentCount = 0.obs;
  RxList<String> documentNames = RxList<String>();
  RxInt totalUsers = 0.obs;
  RxInt homeWins = 0.obs;
  RxInt awayWins = 0.obs;
  RxInt drawingUsers = 0.obs;
  List<ChartData> scoreData = [];
  RxBool showWheel = true.obs;
  Rx<int> streemcontroller = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    //await fetchBets('1264938');
    fetchDocumentCount();
    fetchDocumentNames();
  }

  @override
  void onClose() async {
    super.onClose();
    totalUsers = 0.obs;
    homeWins = 0.obs;
    awayWins = 0.obs;
    drawingUsers = 0.obs;
    streemcontroller.close();
  }

  spinthwheel() {
    streemcontroller.value = Fortune.randomInt(0, betsLength.value);
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return SizedBox(
            width: 300,
            height: 300,
            child: FortuneWheel(
              duration: const Duration(seconds: 5),
              animateFirst: true,
              rotationCount: 10,
              onAnimationEnd: () async {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('the winner'),
                      content: Text(bets[0]['userID'].toString()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              selected: streemcontroller.stream,
               
              items: generateFortuneItems(),
            ),
          );
        });
  }

  List<FortuneItem> generateFortuneItems() {
    return bets.map((bet) {
      final userID = bet['userID'];
      return FortuneItem(child: Text(userID!));
    }).toList();
  }

  calculateStatistics() {
    totalUsers.value = bets.length;

    for (final data in bets) {
      final winTeam = data['winTeam'];
      final winScore = int.parse(data['winScore']!);
      final loseScore = int.parse(data['loseScore']!);
      if (winTeam == matchDetailsController.homeTeamName.value) {
        homeWins.value++;
        print(homeWins);
      } else if (winTeam == matchDetailsController.awayTeamName.value) {
        awayWins.value++;
        print(awayWins);
      } else if (winTeam == 'Drawing') {
        drawingUsers.value++;
      }

      scoreData.add(ChartData(winScore - loseScore));
    }
  }

  Future<void> fetchDocumentNames() async {
    try {
      final querySnapshot = await userBetCollection.get();
      documentNames.assignAll(querySnapshot.docs.map((doc) => doc.id));
    } catch (e) {
      print('Error fetching document names: $e');
    }
  }

  Future<void> fetchDocumentCount() async {
    try {
      final querySnapshot = await userBetCollection.get();
      totalDocumentCount.value = querySnapshot.docs.length;
      print(
          'Total number of documents in "User\'sBet" collection: $totalDocumentCount');
    } catch (e) {
      print('Error fetching document count: $e');
    }
  }

  Future<void> fetchBets(String matchID) async {
    try {
      final querySnapshot = await userBetCollection.doc(matchID).get();
      if (querySnapshot.exists) {
        final data = querySnapshot.data() as Map<String, dynamic>;

        // Check if the array field exists
        if (data.containsKey('bets')) {
          final betArray = data['bets'] as List<dynamic>;

          // Convert betArray to List<Map<String, String>>
          final betsList = betArray.map((bet) {
            final loseScore = bet['loseScore'] as String?;
            final userID = bet['userID'] as String?;
            final winScore = bet['winScore'] as String?;
            final winTeam = bet['winTeam'] as String?;

            // Check for null values before assigning to the map
            return {
              'loseScore': loseScore ?? '',
              'userID': userID ?? '',
              'winScore': winScore ?? '',
              'winTeam': winTeam ?? '',
            };
          }).toList();

          bets.assignAll(betsList);

          // Get the length of the betsList
          betsLength.value = betsList.length;

          print('Length of the bets array: $betsLength');
        } else {
          print('Array field not found in Firestore document');
        }
      }
    } catch (e) {
      print('Error fetching bets: $e');
    }
  }
}

class ChartData {
  final int score;

  ChartData(this.score);
}
