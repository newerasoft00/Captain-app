import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/admin%20view/admin%20controller/match_details.dart';
import '../../../../../admin controller/users_bet_controller.dart';
import 'user_bet_details.dart';

class MatchBetDetails extends StatelessWidget {
  const MatchBetDetails({super.key, required this.docName});
  final String docName;

  @override
  Widget build(BuildContext context) {
    final UsersBetController betController = Get.put(UsersBetController());
    MatchDetailsController matchDetailsController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              betController.onClose();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            crossAxisAlignment: context.isLandscape
                ? WrapCrossAlignment.center
                : WrapCrossAlignment.start,
            children: [
              Hero(
                tag:
                    'eventID_$docName', // Make the tag unique by adding the docName
                transitionOnUserGestures: true,
                child: SizedBox(
                  width: context.isPortrait
                      ? context.width * 0.94
                      : context.width * 0.45,
                  height: context.isPortrait
                      ? context.height * 0.10
                      : context.height * 0.15,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    surfaceTintColor: Colors.white,
                    child: ListTile(
                      title: Wrap(
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.spaceEvenly,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SizedBox(
                            height: context.isPortrait
                                ? context.height * 0.07
                                : context.height * 0.10,
                            child: Image.network(
                              matchDetailsController.homeTeamLogoUrl.value,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Text(matchDetailsController.homeTeamName.value),
                          const Text('   vs   '),
                          Text(matchDetailsController.awayTeamName.value),
                          SizedBox(
                            height: context.isPortrait
                                ? context.height * 0.07
                                : context.height * 0.10,
                            child: Image.network(
                              matchDetailsController.awayTeamLogoUrl.value,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                child: UserBetDetails(),
              ),
              10.ph,
              SizedBox(
                width: double.infinity,
                height: context.isPortrait
                    ? context.height * 0.35
                    : context.height * 0.40,
                child: ListView.builder(
                    itemCount: betController.bets.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final bet = betController.bets[index];
                      return Card(
                        color: Colors.white,
                        elevation: 3,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          title: Text('UserID: ${bet['userID']}'),
                          subtitle: Row(
                            children: [
                              Text(
                                'Win Team :  ${bet['winTeam']}',
                                style: const TextStyle(
                                    color: Color(0xffBB2525),
                                    fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              Text(
                                '${bet['winScore']} : ${bet['loseScore']}',
                                style: TextStyle(
                                    color: Colors.lightGreen.shade900,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),

                          // Add more widgets to display other data fields
                        ),
                      );
                    }),
              ),
              SizedBox(
                width: double.infinity,
                height: context.isPortrait
                    ? context.height * 0.11
                    : context.height * 0.40,
                child: Obx(
                  () {
                    if (matchDetailsController.matches.isEmpty) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else {
                      return ListView.builder(
                        itemCount: matchDetailsController.matches.length,
                        itemBuilder: (context, index) {
                          final match = matchDetailsController.matches[index];
                          return ListTile(
                            title: Text(match.eventFinalResult),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(1)
                            ],
                            decoration: const InputDecoration(
                              hintText: 'Enter an integer',
                              contentPadding: EdgeInsets.all(12.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              // Handle the input value here
                              int? enteredValue = int.tryParse(text);
                              if (enteredValue != null) {
                                // Do something with the entered integer
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            10), // Add spacing between the TextField and Button
                    Expanded(
                      flex: 8,
                      child: CupertinoButton.filled(
                        onPressed: () {
                          betController.spinthwheel();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
