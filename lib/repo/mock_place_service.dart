import 'dart:async';

import 'package:airadar/model/place.dart';
import 'package:airadar/repo/mock/mock_place_api_response.dart';
import 'package:airadar/repo/place_repository.dart';

class MockPlaceService implements PlaceRepository {
  @override
  Future<PlaceSuggestions> getPlaceSuggestions(String query) async {
    return MockPlaceApiResponse.placeSuggestions;
  }
}
