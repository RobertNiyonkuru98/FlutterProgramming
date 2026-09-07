// Widget tests "pump" the app on a fake screen and check what it builds.
// Run them with:  flutter test

import 'package:flutter_test/flutter_test.dart';

import 'package:myapplication/main.dart';

void main() {
  testWidgets('Shows Hello World and the name', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // The main title must be on screen.
    expect(find.text('Hello World'), findsOneWidget);

    // The name line must be on screen too (whatever name you set).
    expect(find.textContaining('My name is'), findsOneWidget);
  });
}
