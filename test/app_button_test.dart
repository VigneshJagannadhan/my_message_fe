import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_message_fe/core/widgets/app_button.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('calls onPressed when tapped', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _wrap(AppButton(label: 'Go', onPressed: () => taps++)),
    );

    await tester.tap(find.text('Go'));
    expect(taps, 1);
  });

  testWidgets('shows spinner and ignores taps while loading', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _wrap(AppButton(label: 'Go', isLoading: true, onPressed: () => taps++)),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Go'), findsNothing);

    await tester.tap(find.byType(AppButton), warnIfMissed: false);
    expect(taps, 0);
  });
}
