import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/repo/mock/mock_place_api_response.dart';
import 'package:airadar/repo/mock/mock_place_service.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:airadar/screens/place_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Place Picker Screen', () {
    PlaceRepository repo;
    PlaceBlock block;
    final places = MockPlaceApiResponse.placeSuggestions.places;
    setUpAll(() {
      repo = MockPlaceService();
      block = PlaceBlock(repo);
    });

    testWidgets('fetches data on search query typed',
        (WidgetTester tester) async {
      await prepareWidget(tester, PlacePickerScreen(block));

      expect(find.text('List is empty'), findsOneWidget);
      await tester.pump();

      await tester.enterText(find.byType(TextField), "ASD");

      await tester.pumpAndSettle(Duration(milliseconds: 500));
      expect(find.text(places[0].properties.name), findsOneWidget);
      expect(find.text(places[1].properties.name), findsOneWidget);
      expect(find.text(places[2].properties.name), findsOneWidget);
    });
  });
}

void prepareWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    ),
  );
}
