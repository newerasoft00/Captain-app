import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/modules/user%20feedback/widget/rating_bar.dart';
import 'package:captain/app/utils/Core/helper/empty_padding.dart';
import 'package:captain/app/widgets/custom_appbar.dart';
import 'package:captain/app/widgets/custom_text.dart';

import 'controller/feedback_controller.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feedbackController = Get.put(FeedbackController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Roshan League'.tr,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: feedbackController.feedbackKey,
            child: Column(
              children: [
                20.ph,
                CustomText(
                  title: 'Share your FeedBack and Ratings to help Us'.tr,
                ),
                20.ph,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.primary,
                            spreadRadius: 1,
                            blurRadius: 5),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    validator: feedbackController.validateSubject,
                    scrollPhysics: const AlwaysScrollableScrollPhysics(),
                    maxLines: 7,
                    minLines: 1,
                    onChanged: (value) {
                      feedbackController.feedbackSubject.value = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Subject'.tr,
                        hintStyle: const TextStyle(fontSize: 16)),
                  ),
                ),
                15.ph,
                ratingBarWidget(
                    initialRating: feedbackController.rating.value,
                    onRatingUpdate: (val) {
                      feedbackController.rating.value = val;
                    }),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      if (feedbackController.feedbackKey.currentState!
                          .validate()) {
                        await feedbackController.saveUserFeedback();
                        Get.snackbar(
                            'success'.tr, 'Thanks for your feedback'.tr);
                        // Get.toNamed(Routes.profileScreen);
                        if (context.mounted) Navigator.of(context).pop();
                      }
                    },
                    child: AutoSizeText(
                      'Send'.tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
