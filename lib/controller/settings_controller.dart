import 'dart:async';

import 'package:courses_in_english/model/user/user_settings.dart';

abstract class SettingsController {
  void setSettings(UserSettings userSettings);
  Future<UserSettings> get userSettings;
}
