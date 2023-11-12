/*import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/screens/notifications/notification_screen.dart';

setupNotification() async {
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Get.to(() => NotificationScreen());
    //NotificationController notificationController=NotificationController();
    //notificationController.navigate(event.notification?.title??"",true);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      String body = message.notification!.body!;
      showNotification(message.notification!.title, body);
      Get.to(() => NotificationScreen());
    }
  });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.instance.subscribeToTopic("all");
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("mynotificationtoken = $fcmToken");
}

void showNotification(title, body) {
  AwesomeNotifications().setChannel(NotificationChannel(
    channelKey: "all_notifications",
    channelName: "all_notifications",
    channelDescription: "all_notifications",
  ));
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'all_notifications',
      title: title,
      body: body,
      actionType: ActionType.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'OPEN_SCREEN',
        label: 'Open Screen',
        actionType: ActionType.KeepOnTop,
        enabled: true,
      ),
    ],
  );
}

Future<void> startListeningNotificationEvents() async {
  AwesomeNotifications()
      .setListeners(onActionReceivedMethod: onActionReceivedMethod);
}

Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  if (receivedAction.actionType == ActionType.SilentAction ||
      receivedAction.actionType == ActionType.SilentBackgroundAction) {
    Get.to(() => NotificationScreen());
  } else {
    Get.to(() => NotificationScreen());
  }
}
*/