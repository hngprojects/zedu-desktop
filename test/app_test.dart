import 'package:flutter_starter/app/app.dart';
import 'package:flutter_starter/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the starter app shell', (tester) async {
    await locator.reset();
    setupLocator();

    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('Flutter Starter'), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
