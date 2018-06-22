import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    new Injector().injectDependencies(new MockitoProviderFactory(), new MockedCacheProvidersFactory());
  });
  testWidgets('Settings test skeleton', (tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new SettingsScreen(),
      ),
    ));
  });
}
