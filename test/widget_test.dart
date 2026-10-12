import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:whirldroid/main.dart';
import 'package:whirldroid/models/settings.dart';

void main() {
  testWidgets('WhirldroidApp loads main screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => SettingsProvider(),
        child: const WhirldroidApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
