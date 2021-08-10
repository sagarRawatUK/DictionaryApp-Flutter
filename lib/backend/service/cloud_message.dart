import 'package:dictionaryapp/backend/service/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void initMessaging() async {
    firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) LocalNotificationService.display(message);
      print(message?.data.values);
    });

    print("###### Listening #######");
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification?.body);
        print(message.notification?.title);
      }
      LocalNotificationService.display(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data.values);
    });
  }
}
