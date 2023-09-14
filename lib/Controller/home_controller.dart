import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class HomeController extends GetxController {
  var pageindex = 0.obs;
  RxDouble timerValue = 0.0.obs; // This will hold the timer value in seconds
  late Timer _timer; // Timer instance
  RxBool noselectedMath = false.obs;

  List<String> teamNames = [
    'Team A',
    'Team B',
    'Team C',
    'Team D',
    'Team E',
    'Team F',
    'Team G',
    'Team H',
    'Team I',
    'Team J',
  ];

  List<String> scores = [
    '2-1',
    '0-3',
    '1-1',
    '4-2',
    '3-0',
    '2-2',
    '1-0',
    '2-3',
    '0-1',
    '2-2',
  ];

  final GetStorage box = GetStorage();

  // Constructor to start the timer when the controller is initialized
  HomeController() {
    final random = Random();
    timerValue.value = random.nextInt(91).toDouble();
    // Start the timer immediately when the controller is created
    startTimer();
  }

  void changePageIndex(int index) {
    pageindex.value = index;
    update();
  }

  // Method to start the timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      // Increase the timerValue by 0.5 every second
      timerValue.value += 0.5;

      if (timerValue.value == 90) {
        // Handle the case when the timer reaches 90.0
        resetTimer();
      }
    });
  }

  // Method to stop the timer (call this when you want to stop the timer)
  void stopTimer() {
    _timer.cancel();
  }

  // Method to reset the timer
  void resetTimer() {
    timerValue.value = 0;
  }

  int generateRandomInt() {
    final random = Random();
    return random.nextInt(
        91); // Generates a random integer between 0 (inclusive) and 91 (exclusive)
  }


  @override
  void onClose() {
    // Ensure that the timer is canceled when the controller is closed
    _timer.cancel();
    super.onClose();
  }
}
