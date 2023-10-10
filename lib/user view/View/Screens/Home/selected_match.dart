import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/User%20View/Controller/bet_controller.dart';
import '../../../../res/i_font_res.dart';

class SelectedMatch extends StatelessWidget {
  const SelectedMatch(
      {super.key, required this.selectedmatch, required this.homeTeam});
  final Widget selectedmatch;
  final String homeTeam;

  @override
  Widget build(BuildContext context) {
    final BetOptionController controller = Get.put(BetOptionController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roshn league'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.ph,
              const Text(
                'Bet Now',
                style:
                    TextStyle(fontSize: 22, fontFamily: FontRes.TAJAWAL_MEDIUM),
              ),
              30.ph,
              SizedBox(
                child: selectedmatch,
              ),
              20.ph,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(() {
                  // Use Obx to automatically rebuild the UI when data changes
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (controller.betOptions.isEmpty) {
                      return const Center(
                        child: Text('No Bet available.'),
                      );
                    }
                    // Ensure that rxBoolList is generated before accessing it
                    if (controller.rxBoolList.isEmpty) {
                      controller.generateBool();
                    }
                  }
                  return SizedBox(
                    width: Get.width,
                    child: controller.userbetted.value
                        ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.betOptions.length,
                          itemBuilder: (context, index) {
                            final betOption = controller.betOptions[index];
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Obx(
                                    () => CupertinoCheckbox(
                                      value: controller
                                          .rxBoolList[index].value,
                                      onChanged: (value) async {
                                        for (int i = 0;
                                            i <
                                                controller
                                                    .rxBoolList.length;
                                            i++) {
                                          if (i != index) {
                                            controller.rxBoolList[i].value =
                                                false;
                                          }
                                        }
                                        controller.rxBoolList[index].value =
                                            value!;

                                        /* controller.addBetToFirestore(
                                            UserPreference.getUserid(),
                                            betOption,
                                            homeTeam); */
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(flex: 4, child: Text(betOption))
                              ],
                            );
                          },
                        )
                        : const Center(
                            child: Text('Your Bet has been submitted'),
                          ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
