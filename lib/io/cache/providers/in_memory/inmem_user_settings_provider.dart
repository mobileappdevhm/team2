import 'dart:async';

import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

class InMemoryUserSettingsProvider implements CacheUserSettingsProvider {
  @override
  Future<UserSettings> getCurrentSettings(User user) {
    throw new UnimplementedError('InMemoryUserSettingsProvider');
  }

  @override
  Future<int> putSettings(User user, UserSettings userSettings) {
    throw new UnimplementedError('InMemoryUserSettingsProvider');
  }
}
