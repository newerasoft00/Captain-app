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
    final BetOptionController controller = Get.put(BetOptionController());

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text('Chose on of this option'),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: Get.width,
                height: 50,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.userChoice.value = fixture.eventHomeTeam;
                          },
                          child: Text(
                            fixture.eventHomeTeam,

                            //fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                height: 50,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.userChoice.value = fixture.eventAwayTeam;
                        },
                        child: Text(
                          fixture.eventAwayTeam,

                          //fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                height: 50,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.addDataToFirestore(
                                UserPreference.getUserid(),
                                'Drawing',
                                fixture.awayteamkey.toString());
                          },
                          child: const Text('Drawing')),
                    ],
                  ),
                ),
              ),
              20.ph,
              const Text('Or typing your score prediction'),
              10.ph,
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: TextField(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: TextField(
                          onChanged: (value) {
                            controller.userChoicescore2.value = value;
                          },
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
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
                  if (controller.userChoicescore1.value != '' &&
                      controller.userChoicescore2.value != '') {
                    controller.addDataToFirestore(
                        UserPreference.getUserid(),
                        '${controller.userChoicescore1.value} - ${controller.userChoicescore2.value}',
                        '${fixture.hometeamkey}');
                    Navigator.pop(context);
                    controller.userChoice.value = '';
                    controller.userChoicescore1.value = '';
                    controller.userChoicescore2.value = '';
                  } else if (controller.userChoice.value != '') {
                    controller.addDataToFirestore(UserPreference.getUserid(),
                        controller.userChoice.value, '${fixture.hometeamkey}');
                    Navigator.pop(context);
                    controller.userChoice.value = '';
                    controller.userChoicescore1.value = '';
                    controller.userChoicescore2.value = '';
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
    );
  }
}
