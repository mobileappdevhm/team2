import 'dart:async';

import 'package:courses_in_english/controller/settings_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

class NormalSettingsController implements SettingsController {
  final CacheUserSettingsProvider cacheUserSettingsProvider;

  NormalSettingsController(CacheProviderFactory factory)
      : cacheUserSettingsProvider = factory.createSettingsProvider();

  void setSettings(UserSettings userSettings) {
    cacheUserSettingsProvider.putSettings(userSettings);
  }

  Future<UserSettings> get userSettings async {
    return cacheUserSettingsProvider.getCurrentSettings();
  }

  void clearApp() => cacheUserSettingsProvider.clearApp();
}
