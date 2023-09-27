import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';

class UserBetHistoryController extends GetxController {
  final firestoreInstance = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> betHistory = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchBetHistoryData();
  }

  Future<void> fetchBetHistoryData() async {
    try {
      final userDocRef = FirebaseFirestore.instance
          .collection('User Information')
          .doc(UserPreference.getUserid());

      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data() as Map<String, dynamic>;

        if (userData['betHistory'] != null &&
            userData['betHistory'] is List<dynamic>) {
          final betHistoryData = userData['betHistory'] as List<dynamic>;

          final List<Map<String, dynamic>> fetchedBetHistory = [];

          for (final betData in betHistoryData) {
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
            } else {
              print('One or more fields are null in the bet data');
            }
          }

          betHistory.assignAll(fetchedBetHistory);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          hasError.value = true;
          print('betHistory field is missing or null in the user document');
        }
      } else {
        isLoading.value = false;
        hasError.value = true;
        print('User document does not exist');
      }
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      print('Error fetching bet history data: $e');
    }
  }
}
