import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/model/user/user_settings.dart';
// import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';

// TODO This is a skeleton for the settings controller
class SettingsController {
  static final SettingsController _instance = SettingsController._internal();
  SettingsController._internal();
  factory SettingsController() => _instance;

  //CacheUserSettingsProvider _cacheSettingsProvider;

  void injectDependencies(CacheProviderFactory cacheProviderFactory) {
    // _cacheSettingsProvider = cacheProviderFactory.createSettingsProvider();
  }

  void setSettings(UserSettings userSettings) => throw new UnimplementedError();

  UserSettings get userSettings => new UserSettings();
}
