import 'package:courses_in_english/io/connect/mock_provider_factory.dart';
import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  new Session().setUpProviders(new MockProviderFactory());
  runApp(new CieApp());
}

final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

class CieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _firebaseMessaging.configure(
      ///Fires on notification message if the app is active. Fires on data messages when app is in background (Android, iOS)
      onMessage: (Map<String, dynamic> message) {
        print("onMessage: $message");
      },

      ///Fires on notification message if the app is in the background (Android only)
      onLaunch: (Map<String, dynamic> message) {
        print("onLaunch: $message");
      },

      ///Fires if app is opened from notification (Android only)
      onResume: (Map<String, dynamic> message) {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((String token) {
      //Todo
    });
    _firebaseMessaging.subscribeToTopic("all");

    return new MaterialApp(
      title: 'Cie App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new LoginScreen(),
    );
  }
}
