import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/utils/Core/helper/log_printer.dart';
import 'package:sportsbet/app/utils/Core/themes/theme_controller.dart';
import '../../../utils/Core/helper/shared_preference/shared_preference.dart';
import '../../../utils/Core/utils/strings.dart';
import '../model/user_information.dart';
import '../widget/butom_sheet.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;
  final firestoreInstance = FirebaseFirestore.instance;

  RxBool isLightTheme = true.obs;
  RxList<User> user = RxList<User>();
  User? userInformation;
  RxList<Map<String, dynamic>> betHistory = <Map<String, dynamic>>[].obs;
  RxString selectedLeague = ''.obs;

  final Map<String, Map<String, dynamic>> leagues = leaguesTeams;

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

  Future<void> getUserData() async {
    try {
      final userData = await getUserDocumentData();
      if (userData != null) {
        userInformation = createUserFromData(userData);
        user.add(userInformation!);
      }
    } catch (e) {
      logError('Error getting user document: $e');
    }
  }

  Future<void> fetchBetHistoryData() async {
    try {
      final userData = await getUserDocumentData();
      if (userData != null) {
        betHistory.assignAll(processBetHistoryData(userData['betHistory']));
      }
    } catch (e) {
      logError('Error fetching bet history data: $e');
    }
  }

  Future<void> showLeagueBottomSheet(BuildContext context) async {
    if (GetPlatform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (_) =>
            CupertinoActionSheetWidget(leagues: leagues, controller: this),
      );
    } else {
      await showModalBottomSheet(
        context: context,
        builder: (_) =>
            MaterialBottomSheetWidget(leagues: leagues, controller: this),
      );
    }
  }

  Future<void> handleLeagueSelection(
      Map<String, dynamic> subMap, String leagueName) async {
    selectedLeague.value = subMap.keys.first;
    UserPreference.setSelectedLeague(leagueName);
    UserPreference.setSelectedLeagelogo(subMap.keys.first);
    ThemeController.instance.toggleTheme(subMap[subMap.keys.first]);
    Get.back();
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
