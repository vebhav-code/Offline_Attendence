import 'package:flutter_test/flutter_test.dart';
import 'package:traff_app/main.dart';

void main() {
  testWidgets(
    'App loads successfully',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const SakshamAttendanceApp(),
      );

      expect(
        find.text('Saksham Attendance'),
        findsWidgets,
      );
    },
  );
}
