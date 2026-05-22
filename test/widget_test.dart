import 'package:flutter_test/flutter_test.dart';
import 'package:aoun/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AounApp());
    expect(find.byType(AounApp), findsOneWidget);
  });
}
