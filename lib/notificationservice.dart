import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static Future initialize() async {
    FlutterLocalNotificationsPlugin flns = FlutterLocalNotificationsPlugin();
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var iOSInitialize = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    await flns.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {});
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    FlutterLocalNotificationsPlugin flns = FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('channel1', 'channel_name',
            // playSound: true,
            // sound: RawResourceAndroidNotificationSound('alert'),
            importance: Importance.max,
            priority: Priority.high,
            channelShowBadge: true,
            actions: [AndroidNotificationAction('1', "Accept",)],
            channelAction: AndroidNotificationChannelAction.createIfNotExists);

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await flns.show(0, title, body, not);
  }
}
