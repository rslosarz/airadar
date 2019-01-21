import 'dart:async';

import 'package:airadar/model/place.dart';
import 'package:airadar/repo/place_repository.dart';

class MockPlaceService implements PlaceRepository {
  final mockSuggestions = PlaceSuggestions(
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

  @override
  Future<PlaceSuggestions> getPlaceSuggestions(String query) async {
    return mockSuggestions;
  }
}
