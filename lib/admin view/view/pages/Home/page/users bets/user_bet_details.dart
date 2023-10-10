import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../admin controller/match_details.dart';
import '../../../../../admin controller/users_bet_controller.dart';

class UserBetDetails extends StatelessWidget {
  const UserBetDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MatchDetailsController matchDetailsController =
        Get.put(MatchDetailsController());
    final UsersBetController betController = Get.find();

    return SizedBox(
      height: context.isPortrait
          ? context.height * 0.2
          : context.height * 0.45,
      width:
          context.isPortrait ? context.width * 0.9 : context.width * 0.45,
      child: SfCartesianChart(
        title: ChartTitle(text: 'total bets analysis'),
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          BarSeries<Map<String, String>, String>(
            dataSource: [
              {
                'label': matchDetailsController.homeTeamName.value,
                'value': '${betController.homeWins.value}',
              },
              {
                'label': 'Total bets',
                'value': '${betController.totalUsers.value}',
              },
              {
                'label': matchDetailsController.awayTeamName.value,
                'value': '${betController.awayWins.value}',
              },
              {
                'label': 'Drawing',
                'value': '${betController.drawingUsers.value}',
              },
              // Add more data points with colors
            ],
            pointColorMapper: (datum, index) {
              if (index == 0) {
                return const Color(
                    0xff98D8AA); // Green for even-indexed bars
              } else if (index == 1) {
                return const Color(
                    0xffDF2E38); // Yellow for odd-indexed bars
              } else if (index == 2) {
                return const Color(
                    0xffF7C04A); // Yellow for odd-indexed bars
              } else if (index == 3) {
                return const Color(
                    0xff3F497F); // Yellow for odd-indexed bars
              }
              return null;
            },
            xValueMapper: (Map<String, String> data, _) => data['label'],
            yValueMapper: (Map<String, String> data, _) =>
                double.parse(data['value']!),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
        ],
      ),
    );
  }
}
