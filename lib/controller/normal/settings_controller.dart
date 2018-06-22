import 'package:courses_in_english/controller/settings_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

// TODO This is a skeleton for the settings controller
class NormalSettingsController implements SettingsController {
  final CacheUserSettingsProvider cacheSettingsProvider;

  NormalSettingsController(CacheProviderFactory factory)
      : cacheSettingsProvider = factory.createSettingsProvider();

  @override
  void setSettings(UserSettings userSettings) => throw new UnimplementedError();

  @override
  UserSettings get userSettings => new UserSettings();
}
