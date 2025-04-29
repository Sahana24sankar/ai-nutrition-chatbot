// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_nutrition_chatbot/main.dart'; // Make sure this path matches your project structure

void main() {
  testWidgets('Chatbot UI smoke test', (WidgetTester tester) async {
    // Provide a mock API key for testing.
    const mockApiKey = 'test_api_key';

    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp(mockApiKey));

    // Verify that the chatbot UI is displayed.
    expect(find.text('NutriZen-Bot'), findsOneWidget); // Check for app title
    expect(find.byType(TextField), findsOneWidget); // Check for the input field
    expect(find.byType(IconButton),
        findsWidgets); // Check for mic and send buttons
  });
}
