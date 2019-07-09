import 'dart:convert';

PlaceSuggestions placeSuggestionsFromJson(String str) {
  final jsonData = json.decode(str);
  return PlaceSuggestions.fromJson(jsonData);
}

String placeSuggestionsToJson(PlaceSuggestions data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class PlaceSuggestions {
  List<Place> places;
  String type;

  PlaceSuggestions({
    this.places,
    this.type,
  });

  factory PlaceSuggestions.fromJson(Map<String, dynamic> json) =>
      new PlaceSuggestions(
        places: new List<Place>.from(
            json["features"].map((x) => Place.fromJson(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "features": new List<dynamic>.from(places.map((x) => x.toJson())),
        "type": type,
      };
}

class Place {
  Geometry geometry;
  String type;
  Properties properties;

  Place({
    this.geometry,
    this.type,
    this.properties,
  });

  factory Place.fromJson(Map<String, dynamic> json) => new Place(
        geometry: Geometry.fromJson(json["geometry"]),
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "type": type,
        "properties": properties.toJson(),
      };
}

class Geometry {
  List<double> coordinates;
  String type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => new Geometry(
        coordinates:
            new List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": new List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  String country;
  String city;
  String placeType;
  String postcode;
  String name;
  String state;

  Properties({
    this.country,
    this.city,
    this.placeType,
    this.postcode,
    this.name,
    this.state,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => new Properties(
        country: json["country"],
        city: json["city"] == null ? null : json["city"],
        placeType: json["osm_value"],
        postcode: json["postcode"],
        name: json["name"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city == null ? null : city,
        "osm_value": placeType,
        "postcode": postcode,
        "name": name,
        "state": state,
      };
}
