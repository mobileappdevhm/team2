import 'package:courses_in_english/model/user/user_settings.dart';
import 'dart:async';

/// Abstract class to provide local settings. Doesn't use futures, as there is no need to sync settings at runtime.
abstract class UserSettingsProvider {
  Future<UserSettings> getCurrentSettings();
  Future<int> putCurrentSettings(UserSettings userSettings);
  Future<int> putSettings(UserSettings userSettings);
}
