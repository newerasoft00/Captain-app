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
      }
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Future<bool> doesMapContainKey(String userId, String homeTeam) async {
    try {
      final DocumentReference st1DocRef =
          FirebaseFirestore.instance.collection("User'sBet").doc(homeTeam);
      final DocumentSnapshot st1Doc = await st1DocRef.get();
      if (st1Doc.exists) {
        final Map<String, dynamic> data = st1Doc.data() as Map<String, dynamic>;
        if (data.containsKey(userId)) {
          userbetted.value = true;
          return true;
        }
      }
      userbetted.value = true;
      return false;
    } catch (e) {
      Get.snackbar('error', 'error message: {$e.message}');
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
}
