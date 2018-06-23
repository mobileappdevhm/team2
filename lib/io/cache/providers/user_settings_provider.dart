import 'dart:async';

import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

/// Abstract class to provide local settings. Doesn't use futures, as there is no need to sync settings at runtime.
abstract class CacheUserSettingsProvider {
  Future<UserSettings> getCurrentSettings(User user);

  Future<int> putSettings(User user, UserSettings userSettings);

  void clearApp();
}
