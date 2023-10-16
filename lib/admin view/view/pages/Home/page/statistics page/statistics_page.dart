import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/admin%20view/admin%20controller/statistics_controller.dart';

import '../../../../../admin controller/users_bet_controller.dart';
import 'widget/custom_container.dart';

class Statisticspage extends StatelessWidget {
  const Statisticspage({super.key});

  @override
  Widget build(BuildContext context) {
    StatisticsController c = Get.put(StatisticsController());
    UsersBetController betController = Get.find();
    TextEditingController textEditingController = TextEditingController();
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        primary: true,
        child: Wrap(
          children: [
            Obx(
              () => CustomContainer(
                color: const Color(0xffE9DDFF),
                title: 'total user',
                body: '${c.userCount.value}',
                status: '1 new users',
              ),
            ),
            Obx(
              () => CustomContainer(
                color: const Color(0xffE9DDFF),
                title: 'matches have a bet',
                body: '${betController.totalDocumentCount.value}',
                status: 'matche bet',
              ),
            ),
            const CustomContainer(
              color: Color(0xffE9DDFF),
              title: 'total match',
              body: '9',
              status: '',
            ),
          ],
        ),
      ),
    );
  }
}
