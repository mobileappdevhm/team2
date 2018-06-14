import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';
import 'dart:async';

class MockUserSettingsProvider extends UserSettingsProvider {
  UserSettings _settings = new UserSettings();

  @override
  Future<UserSettings> getCurrentSettings() {
    return new Future(() => _settings);
  }

  Future<int> putCurrentSettings(UserSettings userSettings) {
    return new Future(() => 0);
  }

  Future<int> putSettings(UserSettings userSettings) {
    return new Future(() => 0);
  }
}
