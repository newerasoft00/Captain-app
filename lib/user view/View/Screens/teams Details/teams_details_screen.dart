import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/teams Details/teams_details_controller.dart';

class TeamDetailsScreen extends StatelessWidget {
  final TeamsDetailsController controller = Get.put(TeamsDetailsController());

  TeamDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team List'),
      ),
      body: Obx(
        () {
          if (controller.teams.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return ListView.builder(
              itemCount: controller.teams.length,
              itemBuilder: (context, index) {
                final team = controller.teams[index];
                return GestureDetector(
                  onTap: () {
                    
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                team.teamLogo,
                                width: 40,
                                height: 40,
                              ),
                            ),
                            Expanded(flex: 5, child: Text(team.teamName)),
                            const Spacer(),
                            const Expanded(child: Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                      ),
                      const Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 0.05,
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
