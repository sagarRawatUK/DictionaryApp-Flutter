import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void init() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print(payload);
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().microsecondsSinceEpoch ~/ 10000000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "DictionaryApp", "DictionaryApp Channel", "This is Channel",
              importance: Importance.high, priority: Priority.high));
      await notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data["route"]);
    } on Exception catch (e) {
      print(e);
    }
  }
}
