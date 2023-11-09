import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbet/Core/utils/strings.dart';
import 'dart:convert';

import '../../../Model/Roshn League/roshn_top_scorer.dart';



class TopScorerController extends GetxController {
  final String apiUrl =
      allsportsapi+topScorerapi+allsportsapiKey;

  final topScorers = <RoshnTopScorer>[].obs;

  @override
  void onInit() {
    fetchTopScorers();
    super.onInit();
  }

   Future<void> fetchTopScorers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['success'] == 1) {
        final List<dynamic> results = jsonData['result'];
        topScorers.assignAll(
          results.map((item) => RoshnTopScorer.fromJson(item)).toList(),
        );
      } else {
        throw Exception('Failed to load top scorers data');
      }
    } else {
      throw Exception('Failed to load top scorers data');
    }
  }
}
