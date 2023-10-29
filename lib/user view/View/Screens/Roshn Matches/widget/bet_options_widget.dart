import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/User%20View/Controller/bet_controller.dart';

import '../../../../../../Core/helper/shared_preference/shared_preference.dart';
import '../../../../../Model/Roshn League/game_weak.dart';
import '../../../../../Model/bet/user_bet.dart';
import '../../../../Services/bet/get_user_bet.dart';

class BetOptionsWidget extends StatelessWidget {
  const BetOptionsWidget({super.key, required this.fixture});
  final RoshnMatch fixture;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final BetOptionController controller = Get.put(BetOptionController());
    final GetUserBetService getUserBetSer = GetUserBetService();

    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.05,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: fixture.homeTeamLogo,
                          width: context.width * 0.3,
                          height: context.height * 0.3,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                          imageUrl: fixture.awayTeamLogo,
                          width: context.width * 0.3,
                          height: context.height * 0.3,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Choose who will win',
                      textAlign: TextAlign.center,
                    ),
                    20.ph,
                    SizedBox(
                      width: double.infinity,
                      child: StreamBuilder<NewBet?>(
                        stream: getUserBetSer.getUserBetStream(
                          fixture.leagueRound,
                          fixture.eventKey.toString(),
                          UserPreference.getUserid(),
                        ),
                        builder: (context, snapshot) {
                          int totalUsers = controller.usersChoseHomeTeam.value +
                              controller.usersChoseAwayTeam.value +
                              controller.usersChoseDrawing.value;

                          double homeTeamPercentage =
                              ((controller.usersChoseHomeTeam.value /
                                      totalUsers) *
                                  100);
                          double awayTeamPercentage =
                              (controller.usersChoseAwayTeam.value /
                                      totalUsers) *
                                  100;
                          double drawingPercentage =
                              (controller.usersChoseDrawing.value /
                                      totalUsers) *
                                  100;
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          } else if (snapshot.hasError) {
                            return const Text('');
                          } else {
                            final userBet = snapshot.data;

                            if (userBet == null) {
                              return const SizedBox(
                                height: 1,
                              );
                            }

                            // Display the user's bet data
                            return Column(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.info_outline_rounded,
                                              color: Colors.redAccent,
                                            )),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                              'Your Previous Bet is : ${userBet.winTeam} : ${userBet.winScore} - ${userBet.loseScore}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                15.ph,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: homeTeamPercentage == 0
                                              ? 1
                                              : 1 + homeTeamPercentage.toInt(),
                                          child: Column(
                                            children: [
                                              LinearProgressIndicator(
                                                value: 100,
                                                valueColor: AlwaysStoppedAnimation<
                                                    Color>((homeTeamPercentage >
                                                            awayTeamPercentage &&
                                                        homeTeamPercentage >
                                                            drawingPercentage)
                                                    ? Colors.blue.shade700
                                                    : Colors.grey.shade400),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              homeTeamPercentage == 0
                                                  ? const SizedBox()
                                                  : Text(
                                                      '${homeTeamPercentage.toStringAsFixed(1)}% Home Win',
                                                    ),
                                            ],
                                          ),
                                        ),
                                        5.pw,
                                        Expanded(
                                          flex: drawingPercentage == 0
                                              ? 1
                                              : 1 + drawingPercentage.toInt(),
                                          child: Column(
                                            children: [
                                              LinearProgressIndicator(
                                                value: 100,
                                                valueColor: AlwaysStoppedAnimation<
                                                    Color>((drawingPercentage >
                                                            awayTeamPercentage &&
                                                        drawingPercentage >
                                                            homeTeamPercentage)
                                                    ? Colors.blue.shade700
                                                    : Colors.grey.shade400),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              drawingPercentage == 0
                                                  ? const SizedBox()
                                                  : Text(
                                                      '${drawingPercentage.toStringAsFixed(1)}% Drawing',
                                                    ),
                                            ],
                                          ),
                                        ),
                                        5.pw,
                                        Expanded(
                                          flex: awayTeamPercentage == 0
                                              ? 1
                                              : 1 + awayTeamPercentage.toInt(),
                                          child: Column(
                                            children: [
                                              LinearProgressIndicator(
                                                value: 100,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  (awayTeamPercentage >
                                                              homeTeamPercentage &&
                                                          awayTeamPercentage >
                                                              drawingPercentage)
                                                      ? Colors.blue.shade700
                                                      : Colors.grey.shade400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              awayTeamPercentage == 0
                                                  ? const SizedBox()
                                                  : Text(
                                                      '${awayTeamPercentage.toStringAsFixed(1)}% Away Win',
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                5.ph,
                                Text('total bet is : $totalUsers'),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    20.ph,
                    Divider(color: Colors.grey.shade300),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.awaybetted.value = false;
                            controller.drawbetted.value = false;
                            controller.homebetted.value = true;
                            controller.userChoice.value = fixture.eventHomeTeam;
                          },
                          child: SizedBox(
                              width: context.width / 3.5,
                              height: 50,
                              child: Obx(
                                () => Card(
                                  color: !controller.homebetted.value
                                      ? Theme.of(context).cardColor
                                      : Colors.tealAccent.shade700,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                            controller.userChoice.value = fixture.eventAwayTeam;
                          },
                          child: SizedBox(
                            width: context.width / 3.5,
                            height: 50,
                            child: Obx(
                              () => Card(
                                color: !controller.awaybetted.value
                                    ? Theme.of(context).cardColor
                                    : Colors.tealAccent.shade700,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                            controller.userChoice.value = 'Drawing';
                          },
                          child: SizedBox(
                              width: context.width / 3.5,
                              height: 50,
                              child: Obx(
                                () => Card(
                                  color: !controller.drawbetted.value
                                      ? Theme.of(context).cardColor
                                      : Colors.tealAccent.shade700,
                                  // ignore: prefer_const_constructors
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text('Drawing'),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        30.ph,
                        Obx(() => (controller.awaybetted.value != false ||
                                controller.drawbetted.value != false ||
                                controller.homebetted.value != false)
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: Get.width,
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) => controller
                                                .validateHomeBet(value),
                                            onChanged: (value) {
                                              controller.userChoicescore1
                                                  .value = value;
                                            },
                                            textAlign: TextAlign.center,
                                            maxLength: 1,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              hintText: fixture.eventHomeTeam,
                                              counterText: '',
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: TextFormField(
                                            onChanged: (value) {
                                              controller.userChoicescore2
                                                  .value = value;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) => controller
                                                .validateAwayBet(value),
                                            textAlign: TextAlign.center,
                                            maxLength: 1,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              hintText: fixture.eventAwayTeam,
                                              counterText: '',
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox())
                      ],
                    ),
                    context.isPortrait
                        ? SizedBox(
                            height: context.height * 0.12,
                          )
                        : 40.ph,
                    SizedBox(
                      width: Get.width,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).cardColor,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate() &&
                                controller.userChoicescore1.value != '' &&
                                controller.userChoicescore2.value != '') {
                              if (controller.drawbetted.value == true &&
                                  controller.userChoicescore1 !=
                                      controller.userChoicescore2) {
                                Get.snackbar('error', 'Score must be a equal',
                                    backgroundColor: Colors.redAccent);
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.rightSlide,
                                  title:
                                      '${fixture.eventHomeTeam} - ${controller.userChoicescore1}  :  ${fixture.eventAwayTeam} - ${controller.userChoicescore2}',
                                  desc: 'Confirm Your Choice',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    if (controller.drawbetted.value == true) {
                                      if (controller.userChoicescore1.value ==
                                          controller.userChoicescore2.value) {
                                        controller.addBetToFirestore(
                                            fixture.leagueRound,
                                            UserPreference.getUserid(),
                                            controller.userChoice.value,
                                            '${fixture.eventKey}',
                                            controller.userChoicescore1.value,
                                            controller.userChoicescore2.value);
                                        controller.saveUserBetinFireStore(
                                            UserPreference.getUserid(),
                                            '${fixture.eventKey}',
                                            '${fixture.eventHomeTeam} - ${fixture.eventAwayTeam}',
                                            fixture.leagueRound,
                                            '${controller.userChoicescore1.value} - ${controller.userChoicescore2.value}');

                                        controller.userChoice.value = '';
                                        controller.userChoicescore1.value = '';
                                        controller.userChoicescore2.value = '';
                                        controller.awaybetted.value = false;
                                        controller.drawbetted.value = false;
                                        controller.homebetted.value = false;
                                        Navigator.pop(context);
                                      }
                                    } else if (controller
                                                .userChoicescore1.value !=
                                            '' &&
                                        controller.userChoicescore2.value !=
                                            '' &&
                                        controller.userChoice.value != '') {
                                      controller.addBetToFirestore(
                                          fixture.leagueRound,
                                          UserPreference.getUserid(),
                                          controller.userChoice.value,
                                          '${fixture.eventKey}',
                                          controller.userChoicescore1.value,
                                          controller.userChoicescore2.value);
                                      controller.saveUserBetinFireStore(
                                          UserPreference.getUserid(),
                                          '${fixture.eventKey}',
                                          '${fixture.eventHomeTeam} - ${fixture.eventAwayTeam}',
                                          fixture.leagueRound,
                                          '${controller.userChoicescore1.value} - ${controller.userChoicescore2.value}');

                                      controller.userChoice.value = '';
                                      controller.userChoicescore1.value = '';
                                      controller.userChoicescore2.value = '';
                                      controller.awaybetted.value = false;
                                      controller.drawbetted.value = false;
                                      controller.homebetted.value = false;
                                      Navigator.pop(context);
                                    }
                                  },
                                ).show();
                              }
                            } else {
                              Get.snackbar('error', 'Score not valid',
                                  backgroundColor: Colors.red.shade600);
                            }
                          },
                          child: FittedBox(
                              child: Obx(
                            () => (controller.drawbetted.value == true &&
                                    controller.userChoicescore1.value !=
                                        controller.userChoicescore2.value)
                                ? const Text(
                                    'Score must be equal',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Save Bet',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
