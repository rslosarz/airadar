import 'package:airadar/blocks/place_block.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:airadar/screens/place_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPlaceService extends Mock implements PlaceRepository {}

void main() {
  group('Place Picker Screen', () {
    PlaceRepository repo;
    PlaceBlock block;
    final placeSuggestions = PlaceSuggestions(
      places: [
        Place(
          type: "A",
          geometry: Geometry(coordinates: [1.0, 2.0]),
          properties: Properties(
            country: "Poland",
            placeType: "city",
            name: "Poznan",
          ),
        ),
        Place(
          type: "B",
          geometry: Geometry(coordinates: [1.0, 2.0]),
          properties: Properties(
            country: "Germany",
            placeType: "village",
            name: "Berlin",
          ),
        ),
      ],
    );

    setUpAll(() {
      repo = MockPlaceService();
      when(repo.getPlaceSuggestions("ASD"))
          .thenAnswer((_) async => placeSuggestions);
      block = PlaceBlock(repo);
    });

    testWidgets('fetches data on search query typed',
        (WidgetTester tester) async {
      await prepareWidget(tester, PlacePickerScreen(block));

      expect(find.text('List is empty'), findsOneWidget);
      await tester.pump();

      await tester.enterText(find.byType(TextField), "ASD");

      await tester.pumpAndSettle(Duration(milliseconds: 500));
      expect(find.text("Poznan"), findsOneWidget);
      expect(find.text("Berlin"), findsOneWidget);
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
