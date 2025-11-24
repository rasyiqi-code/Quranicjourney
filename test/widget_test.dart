import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quranic_journey/main.dart';

void main() {
  testWidgets('App should start', (WidgetTester tester) async {
    await tester.pumpWidget(const QuranicJourneyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
