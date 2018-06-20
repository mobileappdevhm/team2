import 'package:courses_in_english/controller/cie_controller.dart';
import 'package:courses_in_english/controller/content_controller.dart';
import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/controller/firebase_controller.dart';
import 'package:courses_in_english/controller/session_controller.dart';
import 'package:courses_in_english/io/cache/in_memory_provider_factory.dart';
import 'package:courses_in_english/io/cache/sqlite_provider_factory.dart';
import 'package:courses_in_english/io/inet/mock_inet_provider_factory.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  new ContentController().injectDependencies(
      new MockProviderFactory(), new SqliteProviderFactory());
  new SessionController().injectDependencies(
      new MockProviderFactory(), new SqliteProviderFactory(), new FirebaseController());
  // TODO switch to sql
  new FavoritesController().injectDependencies(
      new MockProviderFactory(), new InMemoryProviderFactory(), new FirebaseController());
  new CieController().injectDependencies(new SqliteProviderFactory(), new FirebaseController());
  runApp(new CieApp());
}

class CieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cie App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new LoginScreen(),
      navigatorObservers: [new FirebaseController().analyticsObserver],
    );
  }
}
