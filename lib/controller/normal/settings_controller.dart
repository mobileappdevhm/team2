import 'dart:async';

import 'package:courses_in_english/controller/settings_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

// TODO This is a skeleton for the settings controller
class NormalSettingsController implements SettingsController {
  final CacheUserSettingsProvider cacheUserSettingsProvider;

  NormalSettingsController(CacheProviderFactory factory)
      : cacheUserSettingsProvider = factory.createSettingsProvider();

  void setSettings(UserSettings userSettings) {
    cacheUserSettingsProvider.putSettings(
        new User(null, null, null, null, null), userSettings);
  } //TODO PULL CUTTENR USER INSTEAD OFF NULL USER!!!!!!!!

  Future<UserSettings> get userSettings async {
    return cacheUserSettingsProvider
        .getCurrentSettings(new User(null, null, null, null, null));
  }

  void clearApp() => cacheUserSettingsProvider.clearApp();
}
