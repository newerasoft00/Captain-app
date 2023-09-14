import 'package:get/get.dart';
import 'package:sportsbet/Model/match%20Day%20Models/match_day.dart';
import '../Services/Api/match_day_service.dart';

class MatchDayController extends GetxController {
  final MatchDayService matchService = MatchDayService();
 var matches = <MatchDay>[].obs;
  @override
  void onInit() {
    fetchMatches(1); // Fetch matches for match day 1 initially
    super.onInit();
  }

  void fetchMatches(int matchDay) {
    matchService.fetchMatches(matchDay);
  }
}
