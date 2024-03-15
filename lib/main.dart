

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AuthView/splashScreen.dart';
import 'Screen/notificationScreen.dart';
import 'Screen/paymentHistory_scr.dart';
import 'Screen/wallet_screen.dart';
import 'firebase_notification.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  try{
    String? token = await FirebaseMessaging.instance.getToken();
    print("--device---------token:-----${token}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('deviceToken',token.toString() );
  } on FirebaseException{
    print('__________FirebaseException_____________');
  }
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,

  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book And Play Vendor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: SplashScreen (),
        // home:notificationScr(),
    );
  }
}
