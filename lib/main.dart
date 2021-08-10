import 'package:connectivity/connectivity.dart';
import 'package:dictionaryapp/backend/cubit/connnectivity_cubit.dart';
import 'package:dictionaryapp/backend/cubit/dictionary_cubit.dart';
import 'package:dictionaryapp/backend/repo/word_repo.dart';
import 'package:dictionaryapp/backend/service/local_notification.dart';
import 'package:dictionaryapp/components/style.dart';
import 'package:dictionaryapp/frontend/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
      "Handling a background message: ${message.notification?.body} \n ${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnnectivityCubit(Connectivity()),
        ),
        BlocProvider(
          create: (context) => DictionaryCubit(
              WordRepo(), BlocProvider.of<ConnnectivityCubit>(context)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: themeData,
      ),
    );
  }
}
