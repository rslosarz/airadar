import 'dart:async';

import 'package:airadar/model/place.dart';

abstract class PlaceRepository {
  Future<PlaceSuggestions> getPlaceSuggestions(String query);
}
