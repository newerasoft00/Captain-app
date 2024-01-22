import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:captain/app/utils/Core/helper/log_printer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ad_model.dart';

class AdvertisersController extends GetxController {
  AdvertisersController get instance => Get.find();
  RxList<Advertiser> advertisers = <Advertiser>[].obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    fetchAdvertisers();
    scrollController = ScrollController();
  }

  Future<void> fetchAdvertisers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('advertisors').get();

      advertisers.assignAll(querySnapshot.docs.map((doc) {
        return Advertiser.fromJson(doc.data());
      }).toList());
    } catch (error) {
      logError("Error fetching advertisers: $error");
    }
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
