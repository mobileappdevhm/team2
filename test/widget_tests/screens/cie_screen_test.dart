import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/screens/cie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  MockitoProviderFactory inetFactory;
  MockedCacheProvidersFactory cacheFactory;
  setUp(() {
    inetFactory = new MockitoProviderFactory();
    cacheFactory = new MockedCacheProvidersFactory();
    new Injector()
        .injectDependencies(inetFactory, cacheFactory, firebase: false);
  });
  testWidgets('Test guest view', (WidgetTester tester) async {
    await tester
        .pumpWidget(new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.text("Guest Users don't have profiles"), findsOneWidget);
    expect(find.byType(LineSeparator), findsOneWidget);
  });
  testWidgets('Test logged in view', (WidgetTester tester) async {
    when(inetFactory.userProvider.login('d', 'd'))
        .thenAnswer((_) => Future.value(user));
    when(cacheFactory.cacheCieProvider.getCies(user))
        .thenAnswer((_) => Future.value(<Cie>[]));
    await new Injector().sessionController.login('d', 'd');
    await tester
        .pumpWidget(new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.text("Logout"), findsOneWidget);
    expect(find.widgetWithText(RawMaterialButton, "Logout"), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
    expect(find.widgetWithText(RawMaterialButton, "Add CIE"), findsOneWidget);
  });
}
