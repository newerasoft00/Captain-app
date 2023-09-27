import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import '../../../../Controller/bet_controller.dart';
import '../../../../Core/helper/shared_preference/shared_preference.dart';
import '../../../../Model/Roshn League/game_weak.dart';

class BetOptionsWidget extends StatelessWidget {
  const BetOptionsWidget({super.key, required this.fixture});
  final RoshnMatch fixture;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final BetOptionController controller = Get.put(BetOptionController());

    return Form(
        key: formKey,
        child:
            // If the user has not chosen a bet, display the bet options widget
            Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Chose on of this option and\nand write your score for this match',
                textAlign: TextAlign.center,
              ),
              20.ph,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.awaybetted.value = false;
                      controller.drawbetted.value = false;
                      controller.homebetted.value = true;
                      controller.userChoice.value = fixture.eventHomeTeam;
                    },
                    child: SizedBox(
                        width: Get.width,
                        height: 50,
                        child: Obx(
                          () => Card(
                            color: !controller.homebetted.value
                                ? Theme.of(context).cardColor
                                : Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  fixture.eventHomeTeam,

                                  //fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.awaybetted.value = true;
                      controller.drawbetted.value = false;
                      controller.homebetted.value = false;
                      controller.userChoice.value = fixture.eventHomeTeam;
                    },
                    child: SizedBox(
                      width: Get.width,
                      height: 50,
                      child: Obx(
                        () => Card(
                          color: !controller.awaybetted.value
                              ? Theme.of(context).cardColor
                              : Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                fixture.eventAwayTeam,

                                //fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.awaybetted.value = false;
                      controller.drawbetted.value = true;
                      controller.homebetted.value = false;
                      controller.userChoice.value = fixture.eventHomeTeam;
                    },
                    child: SizedBox(
                        width: Get.width,
                        height: 50,
                        child: Obx(
                          () => Card(
                            color: !controller.drawbetted.value
                                ? Theme.of(context).cardColor
                                : Colors.green,
                            // ignore: prefer_const_constructors
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('Drawing'),
                              ],
                            ),
                          ),
                        )),
                  ),
                  20.ph,
                  10.ph,
                  Obx(() => (controller.awaybetted.value != false ||
                          controller.drawbetted.value != false ||
                          controller.homebetted.value != false)
                      ? SizedBox(
                          width: Get.width,
                          child: Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        controller.validateHomeBet(value),
                                    onChanged: (value) {
                                      controller.userChoicescore1.value = value;
                                    },
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      hintText: fixture.eventHomeTeam,
                                      counterText: '',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      controller.userChoicescore2.value = value;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        controller.validateAwayBet(value),
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      hintText: fixture.eventAwayTeam,
                                      counterText: '',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                      : const SizedBox())
                ],
              ),
              100.ph,
              SizedBox(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // Validation passed, perform your action
                        if (controller.userChoicescore1.value ==
                            controller.userChoicescore2.value) {
                          controller.addBetToFirestore(
                              UserPreference.getUserid(),
                              controller.userChoice.value,
                              '${fixture.eventKey}',
                              controller.userChoicescore1.value,
                              controller.userChoicescore2.value);
                          controller.saveUserBetinFireStore(
                              UserPreference.getUserid(),
                              '${fixture.eventKey}',
                              fixture.eventDate,
                              '${fixture.eventHomeTeam} : ${fixture.eventAwayTeam}',
                              '${controller.userChoicescore1.value} : ${controller.userChoicescore2.value}');
                          Navigator.pop(context);
                        } else if (controller.userChoicescore1.value != '' &&
                            controller.userChoicescore2.value != '' &&
                            controller.userChoice.value != '') {
                          controller.addBetToFirestore(
                              UserPreference.getUserid(),
                              controller.userChoice.value,
                              '${fixture.eventKey}',
                              controller.userChoicescore1.value,
                              controller.userChoicescore2.value);
                          controller.saveUserBetinFireStore(
                              UserPreference.getUserid(),
                              '${fixture.eventKey}',
                              fixture.eventDate,
                              '${fixture.eventHomeTeam} : ${fixture.eventAwayTeam}',
                              '${controller.userChoicescore1.value} : ${controller.userChoicescore2.value}');
                          Navigator.pop(context);
                          controller.userChoice.value = '';
                          controller.userChoicescore1.value = '';
                          controller.userChoicescore2.value = '';
                          controller.awaybetted.value = false;
                          controller.drawbetted.value = false;
                          controller.homebetted.value = false;
                        }
                      }
                    },
                    child: const FittedBox(
                      child: Text(
                        'Save Bet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
