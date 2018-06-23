import 'package:courses_in_english/model/user/user_settings.dart';
import 'dart:async';

abstract class SettingsController {
  void setSettings(UserSettings userSettings);
  Future<UserSettings> get userSettings;
}
