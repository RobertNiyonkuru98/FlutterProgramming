import 'package:flutter_test/flutter_test.dart';
import 'package:test_connection/main.dart';

void main() {
  testWidgets('MyApp loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
  });
}
