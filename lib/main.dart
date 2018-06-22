import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/in_memory_provider_factory.dart';
import 'package:courses_in_english/io/inet/prod_provider_factory.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  new Injector().injectDependencies(
      // new MockProviderFactory(),
      new ProviderFactory(),
      new InMemoryProviderFactory());
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
      navigatorObservers: [new Injector().firebaseController.analyticsObserver],
    );
  }
}
