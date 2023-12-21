import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbet/app/utils/Core/helper/log_printer.dart';
import '../../../utils/Core/utils/strings.dart';
import '../model/roshn_standing.dart';

class RoshnStandingsController extends GetxController {
  var standings = <Standing>[].obs;

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(allsportsapi +
          standingsEndPoint +
          allsportsapiKey)); // Replace with your API URL.

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse the JSON response into a List of Standing objects.
        final List<Standing> parsedStandings = List<Standing>.from(
          data['result']['total']
              .map((standing) => Standing.fromJson(standing)),
        );

        // Update the standings list with the parsed data.
        standings.assignAll(parsedStandings);
        for (var team in standings) {
          logError(
              "${team.standingTeam} :{ ${team.teamLogo} : : ${team.teamKey}}");
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // print('Error fetching data: $e');
    }
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
}
