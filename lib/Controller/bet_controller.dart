import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BetOptionController extends GetxController {
  final betOptions = [].obs; // This will hold the data from Firestore
  RxBool checkoptions = false.obs;
  final List<RxBool> rxBoolList = [];
  final RxString selectedM = ''.obs;
  RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  RxBool userbetted = false.obs;
  RxBool homebetted = false.obs;
  RxBool awaybetted = false.obs;
  RxBool drawbetted = false.obs;
  RxString userChoice = ''.obs;
  RxString userChoicescore1 = ''.obs;
  RxString userChoicescore2 = ''.obs;

  void _startLoadingTimeout() {
    Timer(const Duration(seconds: 10), () {
      _isLoading.value = false;
    });
  }

  @override
  void onClose() {
    _isLoading.value = false;
    rxBoolList.clear();
    super.onClose();
  }

  @override
  void onInit() async {
    // Fetch data from Firestore when the controller is initialized
    super.onInit();
    fetchBetOptions(selectedM.value);
    generateBool();
  }

  changeMatch(String value) {
    selectedM.value = value;
    fetchBetOptions(value);
    generateBool();
  }

  generateBool() {
    for (int i = 0; i < betOptions.length; i++) {
      final rxBool = RxBool(false);
      rxBoolList.add(rxBool);
    }
  }

  // featch bet from Firestore
  void fetchBetOptions(String match) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Roshn bet option ')
          .doc(match)
          .get();

      if (documentSnapshot.exists) {
        // Document exists, you can access its data
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final betOptionArray = data['betoption'] as List<dynamic>;

        // Update the observable list with Firestore data
        betOptions.assignAll(betOptionArray);
      }
    } catch (e) {
      _isLoading = false.obs;
    }
  }

  void addDataToFirestore(
      String userId, String chosenbet, String homeTeam) async {
    try {
      final CollectionReference userBetCollection =
          FirebaseFirestore.instance.collection("User'sBet");

      // Assuming you have a user ID, use it to reference the user's document
      final DocumentReference userDocRef = userBetCollection.doc(homeTeam);

      // Fetch the current data from Firestore
      final DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        // If the document exists, update the 'st_1_bet' array field with new data
        await userDocRef.update({userId: chosenbet});
      } else if (!userDoc.exists) {
        await FirebaseFirestore.instance
            .collection("User'sBet")
            .doc(homeTeam)
            .set({userId: chosenbet});
         final CollectionReference checkBetCollection =
          FirebaseFirestore.instance.collection("checkBet");
      final DocumentReference checkBetDocRef = checkBetCollection.doc(homeTeam);
      await checkBetDocRef.set({userId: true});
      }
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

Future<bool> doesCheckBetContainUser(String userId, String homeTeam) async {
  try {
    final DocumentReference checkBetDocRef = FirebaseFirestore.instance
        .collection("checkBet")
        .doc(homeTeam);
    final DocumentSnapshot checkBetDoc = await checkBetDocRef.get();

    if (checkBetDoc.exists) {
      final Map<String, dynamic> data =
          checkBetDoc.data() as Map<String, dynamic>;
      if (data.containsKey(userId)) {
        return true;
      }
    }
    return false;
  } catch (e) {
    print('Error checking if "checkBet" contains user: $e');
    return false;
  }
}

  Future<void> resetOptions() async {
    {
      _isLoading = true.obs;
      betOptions.clear();
      rxBoolList.clear();
      generateBool();
      fetchBetOptions(selectedM.value);
      _startLoadingTimeout();
    }
  }

   Future<void> addBet(String userId, String matchId, String selectedOption) async {
    try {
      await FirebaseFirestore.instance.collection('bets').add({
        'userId': userId,
        'matchId': matchId,
        'selectedOption': selectedOption,
      });
      // You can also update your UI or show a confirmation message here.
    } catch (e) {
      print('Error adding bet: $e');
      // Handle error, show error message, or retry logic here.
    }
  }
}
