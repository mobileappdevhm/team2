import 'package:courses_in_english/controller/session_controller.dart';
import 'package:courses_in_english/controller/settings_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:meta/meta.dart';

class FirebaseController {
  static final FirebaseController _instance = FirebaseController._internal();

  final SettingsController _settingsController = new SettingsController();
  final SessionController _sessionController = new SessionController();

  FirebaseController._internal() {
    initializeMessaging();
    if (_settingsController.userSettings.feedbackMode ||
        !_sessionController.isLoggedIn) {
      initializeAnalytics();
    }
  }

  factory FirebaseController() => _instance;

  FirebaseMessaging _firebaseMessaging;
  FirebaseAnalytics _firebaseAnalytics;
  FirebaseAnalyticsObserver _observer;

  void initializeMessaging() {
    _firebaseMessaging = new FirebaseMessaging();

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
  }

  void unloadFirebase() {
    _firebaseMessaging = null;
  }

  void initializeAnalytics() {
    _firebaseAnalytics = new FirebaseAnalytics();
    _observer = new FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
    _firebaseAnalytics.logAppOpen();
  }

  void logLogin() async {
    await _firebaseAnalytics?.logLogin();
  }

  void logEvent({@required String name, Map<String, dynamic> parameters, String value}) async {
    if (parameters != null) {
      await _firebaseAnalytics?.logEvent(name: name, parameters: parameters);
    } else {
      await _firebaseAnalytics?.logEvent(name: name, parameters: <String, dynamic>{
        "value": value.toString()
      });
    }
  }

  FirebaseAnalyticsObserver get analyticsObserver => _observer;
}
