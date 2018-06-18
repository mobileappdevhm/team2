import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';

class CieAnalytics {
  final FirebaseAnalytics _instance = new FirebaseAnalytics();

  void setCurrentScreen({@required screenName}) async {
    await _instance.setCurrentScreen(screenName: screenName);
  }

  void setUserProperty({@required name, @required value}) async {
    await _instance.setUserProperty(name: name, value: value);
  }

  void setUserId({@required id}) async {
    await _instance.setUserId(id);
  }

  void logLogin() async {
    await _instance.logLogin();
  }

  void logOpen() async {
    await _instance.logAppOpen();
  }

  get analytics => _instance;
}
