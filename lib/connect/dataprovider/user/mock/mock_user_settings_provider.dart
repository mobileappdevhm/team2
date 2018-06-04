import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

class MockUserSettingsProvider extends UserSettingsProvider {
  UserSettings _settings = new UserSettings();

  @override
  UserSettings getCurrentSettings() {
    return _settings;
  }
}
