import 'package:flutter_test/flutter_test.dart';
import 'package:covid_tracker/main.dart';

void main() {
  testWidgets('COVID-19 tracker smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CovidTrackerApp());

    // Verify all 4 categories are present
    expect(find.text('COVID-19 Tracker'), findsOneWidget);
    expect(find.text('Total Cases'), findsOneWidget);
    expect(find.text('Active Cases'), findsOneWidget);
    expect(find.text('Deaths'), findsOneWidget);
    expect(find.text('Recovered'), findsOneWidget);

    // Verify formatted numbers with commas
    expect(find.text('9,231,249'), findsOneWidget);
    expect(find.text('123,214'), findsOneWidget);
    expect(find.text('51,245'), findsOneWidget);
    expect(find.text('7,452,340'), findsOneWidget);
  });
}
