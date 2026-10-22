import 'package:flutter_test/flutter_test.dart';

import 'package:my_message_fe/main.dart';

void main() {
  testWidgets('login opens register and back', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome back'), findsOneWidget);

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    expect(find.text('Create account'), findsOneWidget);

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
