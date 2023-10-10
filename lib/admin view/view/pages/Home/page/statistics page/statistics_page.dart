import 'package:anim_search_bar/anim_search_bar.dart';
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
            AnimSearchBar(
              width: 400,
              textController: textEditingController,
              onSuffixTap: () {},
              onSubmitted: (s) {
                return;
              },
            ),
            Obx(
              () => CustomContainer(
                color: const Color(0xff9FCAFF),
                title: 'total user',
                body: '${c.userCount.value}',
                status: '1 new users',
              ),
            ),
            Obx(
              () => CustomContainer(
                color: const Color(0xff9FCAFF),
                title: 'total user',
                body: '${c.userCount.value}',
                status: '1 new users',
              ),
            ),
            Obx(
              () => CustomContainer(
                color: const Color(0xffFFFFFF),
                title: 'Matche bet',
                body: '${betController.totalDocumentCount.value}',
                status: 'matches have a bet',
              ),
            ),
            const CustomContainer(
              color: Color(0xffD1E4FF),
              title: 'total match',
              body: '9',
              status: '',
            ),
            const CustomContainer(
              color: Color.fromARGB(255, 21, 130, 202),
              title: 'data',
              body: 'data',
              status: 'data',
            ),
          ],
        ),
      ),
    );
  }
}
