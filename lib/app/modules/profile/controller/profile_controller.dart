import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../../../utils/Core/utils/strings.dart';
import '../../Roshn Matches/controller/roshn_match_controller.dart';
import '../model/user_information.dart';

class ProfileController extends GetxController {
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;
  final firestoreInstance = FirebaseFirestore.instance;

  RxBool isLightTheme = true.obs;
  RxList<User> user = RxList<User>();
  User? userinformation;
  RxList<Map<String, dynamic>> betHistory = <Map<String, dynamic>>[].obs;
  RxString selectedLeague = ''.obs;

  final Map<String, Map<String, dynamic>> leagues = {
    'Roshn League'.tr: {'assets/Roshn_Saudi_League_Logo.svg.png': '278'},
    'English Premier League'.tr: {
      'assets/Image/Premier-League-Logo.png': '152'
    },
    'La Liga'.tr: {'assets/Image/la-liga.png': '302'},
    'Serie A'.tr: {'assets/Image/saria a.png': '207'},
    'Bundesliga'.tr: {'assets/Image/Bundesliga.svg.png': '175'},
    'Ligue 1'.tr: {'assets/Image/Ligue1.svg.png': '168'},
    'Egypt'.tr: {'assets/Image/Nile.png': '141'},
  };

  Future<void> fetchBetHistoryData() async {
    try {
      final userData = await getUserDocumentData();
      if (userData != null) {
        final betHistoryData = userData['betHistory'] as List<dynamic>;
        final fetchedBetHistory = processBetHistoryData(betHistoryData);
        betHistory.assignAll(fetchedBetHistory);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching bet history data: $e');
      }
    }
  }

  Future<void> getUserData() async {
    try {
      final userData = await getUserDocumentData();
      if (userData != null) {
        final userinfo = createUserFromData(userData);
        userinformation = User.fromJson(userData);
        user.add(userinfo);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user document: $e');
      }
    }
  }

  void showLeagueBottomSheet(BuildContext context) {
    if (GetPlatform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: context.height * 0.55,
            child: CupertinoActionSheet(
              title: Text('Select your favorite League'.tr),
              actions: leagues.keys.map((leagueName) {
                final subMap = leagues[leagueName]!;
                final imagePath = subMap.keys.first;

                return CupertinoActionSheetAction(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(imagePath),
                      ),
                      const SizedBox(width: 10),
                      Text(leagueName.tr),
                    ],
                  ),
                  onPressed: () async {
                    RoshnMatchController c = Get.put(RoshnMatchController());
                    selectedLeague.value = imagePath;
                    UserPreference.setSelectedLeague(leagueName);
                    UserPreference.setSelectedLeagelogo(imagePath);
                    await UserPreference.setLeagueUrl(
                        '$allsportsapi$fixturesEndPoint$allsportsapiKey&from=2023-08-11&to=2024-05-27&leagueId=${subMap[subMap.keys.first]}');
                    await UserPreference.setSelectedLeagueKeys(
                        subMap[subMap.keys.first]);
                    c.refresh();
                    c.fetchData();
                    if (context.mounted) Navigator.of(context).pop();
                  },
                );
              }).toList(),
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'.tr),
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: context.height * 0.5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  children: leagues.keys.map((leagueName) {
                    final subMap = leagues[leagueName]!;
                    final imagePath = subMap.keys.first;

                    return ListTile(
                      leading: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(imagePath),
                      ),
                      title: Text(leagueName.tr),
                      onTap: () async {
                        RoshnMatchController c =
                            Get.put(RoshnMatchController());

                        selectedLeague.value = imagePath;
                        UserPreference.setSelectedLeague(leagueName);
                        UserPreference.setSelectedLeagelogo(imagePath);
                        await UserPreference.setLeagueUrl(
                            '$allsportsapi$fixturesEndPoint$allsportsapiKey&from=${currentDate.value}&to=2024-05-27&leagueId=${subMap[subMap.keys.first]}');
                        await UserPreference.setSelectedLeagueKeys(
                            subMap[subMap.keys.first]);
                        c.refresh();
                        c.fetchData();
                        if (context.mounted) Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
    fetchBetHistoryData();
  }

  @override
  void onClose() {
    user.clear();
    super.onClose();
  }

  Future<Map<String, dynamic>?> getUserDocumentData() async {
    final userDocRef = firestoreInstance
        .collection('User Information')
        .doc(UserPreference.getUserid());
    final userDocSnapshot = await userDocRef.get();

    return userDocSnapshot.exists ? userDocSnapshot.data() : null;
  }

  User createUserFromData(Map<String, dynamic> userData) {
    final String email = userData['email'];
    final String phoneNumber = userData['phoneNumber'];
    final String name = userData['name'];
    final String password = userData['password'];
    final String uid = userData['uid'] ?? ' . ';
    final int totalBetPoint = userData['total_bet_point'] ?? 0;

    return User(
      totalBetPoint: totalBetPoint,
      email: email,
      phoneNumber: phoneNumber,
      name: name,
      password: password,
      uid: uid,
    );
  }

  List<Map<String, dynamic>> processBetHistoryData(List<dynamic> betHistory) {
    final List<Map<String, dynamic>> fetchedBetHistory = [];

    for (final betData in betHistory) {
      final matchDate = betData['match_Date'] as String?;
      final matchId = betData['match_Id'] as String?;
      final teams = betData['teams'] as String?;
      final userBet = betData['user_bet'] as String?;

      if (matchDate != null &&
          matchId != null &&
          teams != null &&
          userBet != null) {
        final betEntry = {
          'match_Date': matchDate,
          'match_Id': matchId,
          'teams': teams,
          'user_bet': userBet,
        };
        fetchedBetHistory.add(betEntry);
      }
    }

    return fetchedBetHistory;
  }
}
