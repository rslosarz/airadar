import 'package:airadar/model/place.dart';
import 'package:airadar/widgets/fetch_error_widget.dart';
import 'package:airadar/widgets/loading_widget.dart';
import 'package:airadar/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FetchErrorWidget', () {
    testWidgets('displays icon and info text', (WidgetTester tester) async {
      await prepareWidget(tester, FetchErrorWidget());

      expect(find.text('Error'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });

  group('LoadingWidget', () {
    testWidgets('displays CircularProgressIndicator',
        (WidgetTester tester) async {
      await prepareWidget(tester, LoadingWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('PlaceItem', () {
    Place place;

    setUpAll(() => place = Place(
          properties: Properties(
            country: "Poland",
            placeType: "city",
            name: "Poznan",
          ),
        ));

    testWidgets('displays place name and country', (WidgetTester tester) async {
      await prepareWidget(tester, PlaceItem(place: place));

      expect(find.text('Poznan'), findsOneWidget);
      expect(find.text('Poland'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
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
