import 'package:courses_in_english/controller/cie_controller.dart';
import 'package:courses_in_english/controller/content_controller.dart';
import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/controller/firebase/fb_cie_controller.dart';
import 'package:courses_in_english/controller/firebase/fb_favorites_controller.dart';
import 'package:courses_in_english/controller/firebase/fb_session_controller.dart';
import 'package:courses_in_english/controller/firebase/firebase_controller.dart';
import 'package:courses_in_english/controller/normal/cie_controller.dart';
import 'package:courses_in_english/controller/normal/content_controller.dart';
import 'package:courses_in_english/controller/normal/favorites_controller.dart';
import 'package:courses_in_english/controller/normal/session_controller.dart';
import 'package:courses_in_english/controller/normal/settings_controller.dart';
import 'package:courses_in_english/controller/normal/timetable_controller.dart';
import 'package:courses_in_english/controller/session_controller.dart';
import 'package:courses_in_english/controller/settings_controller.dart';
import 'package:courses_in_english/controller/timetable_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';

class Injector {
  static final Injector _instance = Injector._internal();
  Injector._internal();
  factory Injector() => _instance;

  CieController _cieController;
  ContentController _contentController;
  FavoritesController _favoritesController;
  SessionController _sessionController;
  SettingsController _settingsController;
  TimetableController _timetableController;
  FirebaseController _firebaseController;

  void injectDependencies(
    InetProviderFactory inetFactory,
    CacheProviderFactory cacheFactory, {
    bool firebase = true,
  }) {
    _settingsController = new NormalSettingsController(cacheFactory);
    _favoritesController =
        new NormalFavoritesController(cacheFactory, inetFactory);
    _sessionController = new NormalSessionController(cacheFactory, inetFactory);
    _cieController = new NormalCieController(cacheFactory);
    _contentController = new NormalContentController(inetFactory, cacheFactory);
    _timetableController = new NormalTimetableController(inetFactory, cacheFactory);
    if (firebase) {
      _firebaseController = new FirebaseController(_settingsController);
      _favoritesController =
          new FbFavoritesController(_firebaseController, _favoritesController);
      _sessionController =
          new FbSessionController(_firebaseController, _sessionController);
      _cieController = new FbCieController(_firebaseController, _cieController);
    }
  }

  CieController get cieController => _cieController;
  ContentController get contentController => _contentController;
  FavoritesController get favoritesController => _favoritesController;
  SessionController get sessionController => _sessionController;
  SettingsController get settingsController => _settingsController;
  FirebaseController get firebaseController => _firebaseController;
  TimetableController get timetableController => _timetableController;
}
