import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/controller/roshn_match_controller.dart';
import 'package:sportsbet/app/modules/profile/model/user_information.dart';
import '../../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../../../utils/Core/utils/strings.dart';

class ProfileController extends GetxController {
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;

  RxBool isLightTheme = true.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  RxList<User> user = RxList<User>();
  User? userinformation;
  RxList<Map<String, dynamic>> betHistory = <Map<String, dynamic>>[].obs;
  RxString selectedLeague = ''.obs;
  Map<String, Map<String, dynamic>> leagues = {
    'Roshn League'.tr: {'assets/Roshn_Saudi_League_Logo.svg.png': '278'},
    'English Premier League'.tr: {
      'assets/Image/Premier-League-Logo.png': '152'
    }, // Replace with actual image path
    'La Liga'.tr: {
      'assets/Image/la-liga.png': '302'
    }, // Replace with actual image path
    'Serie A'.tr: {
      'assets/Image/saria a.png': '207'
    }, // Replace with actual image path
    'Bundesliga'.tr: {
      'assets/Image/Bundesliga.svg.png': '175'
    }, // Replace with actual image path
    'Ligue 1'.tr: {
      'assets/Image/Ligue1.svg.png': '168'
    }, // Replace with actual image path
    'Egypt'.tr: {
      'assets/Image/Nile.png': '141'
    }, // Replace with actual image path
  };
// Function to fetch bet history data
  Future<void> fetchBetHistoryData() async {
    try {
      final userDocRef = FirebaseFirestore.instance
          .collection('User Information')
          .doc(UserPreference.getUserid());

      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data() as Map<String, dynamic>;
        final betHistory = userData['betHistory'] as List<dynamic>;

        // Create an empty list to store the bet history data
        final List<Map<String, dynamic>> fetchedBetHistory = [];

        for (final betData in betHistory) {
          final matchDate = betData['match_Date'] as String?;
          final matchId = betData['match_Id'] as String?;
          final teams = betData['teams'] as String?;
          final userBet = betData['user_bet'] as String?;

          // Check if any of the fields is null before using them
          if (matchDate != null &&
              matchId != null &&
              teams != null &&
              userBet != null) {
            // Create a Map representing each bet entry
            final betEntry = {
              'match_Date': matchDate,
              'match_Id': matchId,
              'teams': teams,
              'user_bet': userBet,
            };
            // Add the bet entry to the list
            fetchedBetHistory.add(betEntry);
          } else {
            // print('One or more fields are null in the bet data');
          }
        }

        // Assign the fetched bet history data to your betHistory property
        betHistory.assignAll(fetchedBetHistory);
      } else {
        // print('User document does not exist');
      }
    } catch (e) {
      // print('Error fetching bet history data: $e');
    }
  }

  Future<void> getUserData() async {
    try {
      final userDocument = await firestoreInstance
          .collection('User Information')
          .doc(UserPreference.getUserid())
          .get();

      if (userDocument.exists) {
        final userData = userDocument.data() as Map<String, dynamic>;

        // Check if fields are not null before accessing them
        final String? email = userData['email'];
        final String? phoneNumber = userData['phoneNumber'];
        final String? name = userData['name'];
        final String? password = userData['password'];
        final String? uid = userData['uid'] ?? ' . ';
        final int? totalBetPoint = userData['total_bet_point'] ?? 0;

        if (email != null &&
            phoneNumber != null &&
            name != null &&
            password != null &&
            uid != null) {
          User userinfo = User(
            totalBetPoint: totalBetPoint ?? 0,
            email: email,
            phoneNumber: phoneNumber,
            name: name,
            password: password,
            uid: uid,
          );
          userinformation = User.fromJson(userData);
          user.add(userinfo);

          // Do something with the user data
        } else {
          // Handle the case where one or more fields are null
          // print('One or more fields in the user data are null');
        }
      } else {
        // Handle the case where the user document doesn't exist
        // print('User document does not exist');
      }
    } catch (e) {
      // print('Error getting user document: $e');
      // Handle errors appropriately
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
}
