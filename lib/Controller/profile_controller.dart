import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';

import '../Model/ads/user_information.dart';

class ProfileController extends GetxController {
  RxBool isLightTheme = true.obs;
  final firestoreInstance = FirebaseFirestore.instance;
  RxList<User> user = RxList<User>();
  User? userinformation;
RxList<Map<String, dynamic>> betHistory = <Map<String, dynamic>>[].obs;

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
          print('One or more fields are null in the bet data');
        }
      }

      // Assign the fetched bet history data to your betHistory property
      betHistory.assignAll(fetchedBetHistory);
      
    } else {
      print('User document does not exist');
    }
  } catch (e) {
    print('Error fetching bet history data: $e');
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
      final String? uid = userData['uid'];

      if (email != null && phoneNumber != null && name != null &&
          password != null && uid != null) {
        User userinfo = User(
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
        print('One or more fields in the user data are null');
      }
    } else {
      // Handle the case where the user document doesn't exist
      print('User document does not exist');
    }
  } catch (e) {
    print('Error getting user document: $e');
    // Handle errors appropriately
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
