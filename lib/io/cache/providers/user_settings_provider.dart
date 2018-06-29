import 'dart:async';

import 'package:courses_in_english/model/user/user_settings.dart';

/// Abstract class to provide local settings.
abstract class CacheUserSettingsProvider {
  Future<UserSettings> getCurrentSettings();

  void putSettings(UserSettings userSettings);

  void clearApp();
}
