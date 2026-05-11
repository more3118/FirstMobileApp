import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter_app/main.dart';

void main() {
  testWidgets('ConverterApp displays UI and converts values', (WidgetTester tester) async {
    await tester.pumpWidget(const ConverterApp());

    expect(find.text('Metric ↔ Imperial Converter'), findsOneWidget);
    expect(find.text('Distance: km → miles'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.enterText(find.byType(TextField), '10');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    expect(find.textContaining('10.00 km ='), findsOneWidget);
  });
}
