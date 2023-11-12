import 'package:get/get.dart';

import '../../../data/repository/todays_match_service.dart';
import '../model/todays_matches.dart';



class ToDaysMatchController extends GetxController {
  
  final matchService = ToDaysMatchService();
  final RxList<ToDaysMatch> todaysmatchesUCL = <ToDaysMatch>[].obs;
  final RxList<ToDaysMatch> todaysmatchesUEL = <ToDaysMatch>[].obs;
  final RxList<ToDaysMatch> todaysmatchesPL = <ToDaysMatch>[].obs;
  final RxList<ToDaysMatch> todaysmatchesRoshn = <ToDaysMatch>[].obs;
  final RxList<ToDaysMatch> todaysmatcheslaLiga = <ToDaysMatch>[].obs;
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;
  DateTime selectedDateTime = DateTime.now();
  @override
  void onInit() async {
    super.onInit();
    await checkConnection();
    fetchMatchesUCL();
    fetchMatchesLaLiga();
    fetchMatchesUEL();
    fetchMatchesRoshn();
    fetchMatchesPL();
  }

  checkConnection() async {
    // var result = await Connectivity().checkConnectivity();
  }

  void fetchMatchesUCL() async {
    try {
      final List<ToDaysMatch> fetchedTodaysMatches =
          await matchService.fetchToDaysMatches('3', currentDate.value);
      todaysmatchesUCL.assignAll(fetchedTodaysMatches);
    } catch (e) {
      // print("Error fetching matches UCL: $e");
    }
  }

  void fetchMatchesRoshn() async {
    try {
      final List<ToDaysMatch> fetchedTodaysMatches =
          await matchService.fetchToDaysMatches('278', currentDate.value);
      todaysmatchesRoshn.assignAll(fetchedTodaysMatches);
    } catch (e) {
      // print("Error fetching matches Roshn: $e");
    }
  }

  void fetchMatchesUEL() async {
    try {
      final List<ToDaysMatch> fetchedTodaysMatches =
          await matchService.fetchToDaysMatches('4', currentDate.value);
      todaysmatchesUEL.assignAll(fetchedTodaysMatches);
    } catch (e) {
      // print("Error fetching matches UEL: $e");
    }
  }

  void fetchMatchesPL() async {
    try {
      final List<ToDaysMatch> fetchedTodaysMatches =
          await matchService.fetchToDaysMatches('152', currentDate.value);
      todaysmatchesPL.assignAll(fetchedTodaysMatches);
    } catch (e) {
      // print("Error fetching matches PL : $e");
    }
  }

  void fetchMatchesLaLiga() async {
    try {
      final List<ToDaysMatch> fetchedTodaysMatches =
          await matchService.fetchToDaysMatches('302', currentDate.value);
      todaysmatcheslaLiga.assignAll(fetchedTodaysMatches);
    } catch (e) {
      // print("Error fetching matches La Liga: $e");
    }
  }

  refeatchMatches() {
    fetchMatchesUCL();
    fetchMatchesLaLiga();
    fetchMatchesUEL();
    fetchMatchesRoshn();
    fetchMatchesPL();
  }

  clearMatches() {
    todaysmatchesRoshn.clear();
    todaysmatchesPL.clear();
    todaysmatchesUCL.clear();
    todaysmatchesUEL.clear();
    todaysmatcheslaLiga.clear();
  }
}
