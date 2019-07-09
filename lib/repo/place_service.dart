import 'dart:async';
import 'dart:convert';

import 'package:airadar/model/place.dart';
import 'package:airadar/repo/place_repository.dart';
import 'package:http/http.dart' as http;

class PlaceService implements PlaceRepository {
  final http.Client client;
  final placeUrl = "photon.komoot.de";
  final apiPath = "/api";

  PlaceService(this.client);

  @override
  Future<PlaceSuggestions> getPlaceSuggestions(String query) async {
    final url =
        Uri.http(placeUrl, apiPath, {"q": query, "lang": "en", "limit": "7"});
    final response = await client.get(url);

    return PlaceSuggestions.fromJson(json.decode(response.body));
  }
}
