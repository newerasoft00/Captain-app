import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  RxInt userCount = 0.obs;
  
  Future<int> getDocumentCount() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("User Information").get();

      int documentCount = querySnapshot.size;
      userCount.value = documentCount;
      return documentCount;
    } catch (e) {
      return 0; // Return 0 in case of an error
    }
  }


  @override
  void onInit() {
    super.onInit();
    getDocumentCount();
  }
}
