import 'package:airadar/model/place.dart';

class MockPlaceApiResponse {
  static final placeSuggestions = PlaceSuggestions(
    places: [
      Place(
        geometry: Geometry(
          coordinates: [20.1021416, 49.4337131], type: "Point",),
        type: "Feature",
        properties: Properties(
            country: "Poland",
            city: "Nowa Biała",
            placeType: "peak",
            postcode: "34-405",
            name: "Grzebieniowa Skała",
            state: "Lesser Poland Voivodeship"
        ),
      ),
      Place(
        geometry: Geometry(
          coordinates: [23.4356451, 53.6188176], type: "Point",),
        type: "Feature",
        properties: Properties(
            country: "Poland",
            city: "Nowa Biała",
            placeType: "village",
            postcode: "16-200",
            name: "Grzebienie",
            state: "Podlaskie Voivodeship"
        ),
      ),
      Place(
        geometry: Geometry(
          coordinates: [18.109657, 54.2959522], type: "Point",),
        type: "Feature",
        properties: Properties(
            country: "Poland",
            city: "Nowa Biała",
            placeType: "hamlet",
            postcode: "83-324",
            name: "Grzebieniec",
            state: "Pomeranian Voivodeship"
        ),
      ),
    ],
  );

  static final placeSuggestionsResponse = """{
    "features": [
        {
            "geometry": {
                "coordinates": [
                    20.1021416,
                    49.4337131
                ],
                "type": "Point"
            },
            "type": "Feature",
            "properties": {
                "osm_id": 2582794303,
                "osm_type": "N",
                "country": "Poland",
                "osm_key": "natural",
                "city": "Nowa Biała",
                "osm_value": "peak",
                "postcode": "34-405",
                "name": "Grzebieniowa Skała",
                "state": "Lesser Poland Voivodeship"
            }
        },
        {
            "geometry": {
                "coordinates": [
                    23.4356451,
                    53.6188176
                ],
                "type": "Point"
            },
            "type": "Feature",
            "properties": {
                "osm_id": 6848660,
                "osm_type": "R",
                "extent": [
                    23.4093673,
                    53.6383915,
                    23.4582043,
                    53.5989957
                ],
                "country": "Poland",
                "osm_key": "place",
                "osm_value": "village",
                "postcode": "16-200",
                "name": "Grzebienie",
                "state": "Podlaskie Voivodeship"
            }
        },
        {
            "geometry": {
                "coordinates": [
                    18.109657,
                    54.2959522
                ],
                "type": "Point"
            },
            "type": "Feature",
            "properties": {
                "osm_id": 31532150,
                "osm_type": "N",
                "country": "Poland",
                "osm_key": "place",
                "osm_value": "hamlet",
                "postcode": "83-324",
                "name": "Grzebieniec",
                "state": "Pomeranian Voivodeship"
            }
        },
        {
            "geometry": {
                "coordinates": [
                    21.5355875,
                    52.1150067
                ],
                "type": "Point"
            },
            "type": "Feature",
            "properties": {
                "osm_id": 4485277521,
                "osm_type": "N",
                "country": "Poland",
                "osm_key": "place",
                "city": "Grzebowilk",
                "osm_value": "suburb",
                "postcode": "05-332",
                "name": "Osiedle Grzebowilk",
                "state": "Masovian Voivodeship"
            }
        },
        {
            "geometry": {
                "coordinates": [
                    21.5944444,
                    51.0794444
                ],
                "type": "Point"
            },
            "type": "Feature",
            "properties": {
                "osm_id": 3009704329,
                "osm_type": "N",
                "country": "Poland",
                "osm_key": "place",
                "osm_value": "hamlet",
                "postcode": "27-350",
                "name": "Grzęba",
                "state": "Masovian Voivodeship"
            }
        },
        {
            "geometry": {
                "coordinates": [
                    15.7496607,
                    50.8211308
                ],
                "type": "Point"
            },
            "type": "Feature",
            "properties": {
                "osm_id": 4739249232,
                "osm_type": "N",
                "country": "Poland",
                "osm_key": "natural",
                "city": "Głębock",
                "osm_value": "peak",
                "postcode": "58-535",
                "name": "Grzebień",
                "state": "Lower Silesian Voivodeship"
            }
        },
        {
            "geometry": {
                "coordinates": [
                    15.6746898,
                    51.02035
                ],
                "type": "Point"
            },
            "type": "Feature",
            "properties": {
                "osm_id": 2427786932,
                "osm_type": "N",
                "country": "Poland",
                "osm_key": "natural",
                "city": "Wleń",
                "osm_value": "peak",
                "postcode": "59-610",
                "name": "Grzębska Góra",
                "state": "Lower Silesian Voivodeship"
            }
        }
    ],
    "type": "FeatureCollection"
}""";

  static final placeSuggestionsEmptyResponse = """{
    "features": [],
    "type": "FeatureCollection"
}""";
}
