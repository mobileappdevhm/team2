import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

class MockUserSettingsProvider extends UserSettingsProvider {

  @override
  UserSettings getCurrentSettings() {
    return new UserSettings();
  }

}