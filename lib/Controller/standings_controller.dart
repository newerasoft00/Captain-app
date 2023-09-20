import 'package:get/get.dart';

import '../Model/teams_standing_model.dart';
import '../Services/Api/standings.dart';

class StandingsController extends GetxController {
  final StandingsService service = StandingsService();
  final RxList<Standingsbondis> standings = <Standingsbondis>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStandings();
  }

  Future<void> fetchStandings() async {
    try {
      final standingsData = await service.getStandings();
      standingsData.sort((a, b) => a.position.compareTo(b.position));
      standings.assignAll(standingsData);
    } catch (error) {
      Get.snackbar('error', 'failed to fetch data');
    }
  }

  Future<void> updataStandings() async {
    standings.clear();
    await fetchStandings();
  }
}
