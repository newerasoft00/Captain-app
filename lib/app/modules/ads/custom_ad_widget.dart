import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/utils/Core/helper/log_printer.dart';
import 'package:captain/app/widgets/custom_text.dart';
import 'ad_controller.dart';
import 'ad_model.dart';

class CustomAdBanner extends StatefulWidget {
  const CustomAdBanner({super.key});

  @override
  State<CustomAdBanner> createState() => _CustomAdBannerState();
}

class _CustomAdBannerState extends State<CustomAdBanner> {
  final AdvertisersController advertisersController = Get.find();
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _scrollController = ScrollController();
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < advertisersController.advertisers.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _scrollController.animateTo(
        _currentIndex * 160.0, // Assuming each advertiser has a width of 160
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 80,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: advertisersController.advertisers.length,
            itemBuilder: (context, index) {
              Advertiser advertiser = advertisersController.advertisers[index];
              return GestureDetector(
                onTap: () async {
                  logError('Try to lunch ${advertiser.website}');
                  advertisersController.launchUrl(advertiser.website);
                },
                child: Card(
                  elevation: 0,
                  child: SizedBox(
                    width: context.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Image.network(
                              advertiser.imageUrl,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomText(
                            title: advertiser.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
