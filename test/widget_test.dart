import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/app.dart';

void main() {
  testWidgets('DBStudio shell shows title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DBStudioApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('DBStudio'), findsWidgets);
  });
}
