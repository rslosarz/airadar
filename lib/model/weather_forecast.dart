// To parse this JSON data, do
//
//     final weatherForecast = weatherForecastFromJson(jsonString);

import 'dart:convert';

WeatherForecast weatherForecastFromJson(String str) {
  final jsonData = json.decode(str);
  return WeatherForecast.fromJson(jsonData);
}

String weatherForecastToJson(WeatherForecast data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class WeatherForecast {
  Coord coord;
  List<Weather> weather;
  Main main;
  Wind wind;
  Clouds clouds;
  Sys sys;
  int id;
  String name;
  int cod;

  WeatherForecast({
    this.coord,
    this.weather,
    this.main,
    this.wind,
    this.clouds,
    this.sys,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      new WeatherForecast(
        coord: Coord.fromJson(json["coord"]),
        weather: new List<Weather>.from(
            json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        sys: Sys.fromJson(json["sys"]),
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": new List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "wind": wind.toJson(),
        "clouds": clouds.toJson(),
        "sys": sys.toJson(),
        "id": id,
        "name": name,
        "cod": cod,
      };
}

class Clouds {
  int all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => new Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class Coord {
  double lon;
  double lat;

  Coord({
    this.lon,
    this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => new Coord(
        lon: json["lon"],
        lat: json["lat"],
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class Main {
  double temp;
  double pressure;
  int humidity;
  double tempMin;
  double tempMax;
  double seaLevel;
  double grndLevel;

  Main({
    this.temp,
    this.pressure,
    this.humidity,
    this.tempMin,
    this.tempMax,
    this.seaLevel,
    this.grndLevel,
  });

//main":{"temp":27.01,"feels_like":26.93,"temp_min":27.01,"temp_max":27.01,"pressure":1011,"humidity":77,"sea_level":1011,"grnd_level":1011},"wind":{"speed":7.31,"deg":16},"clouds":{"all":97},"dt":1579428096,"sys":{"sunrise":1579401634,"sunset":1579445279},"timezone":10800,"id":0,"name":"","cod":200}
  factory Main.fromJson(Map<String, dynamic> json) => new Main(
        temp: json["temp"].toDouble(),
        pressure: json["pressure"].toDouble(),
        humidity: json["humidity"],
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        seaLevel: json["sea_level"].toDouble(),
        grndLevel: json["grnd_level"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "pressure": pressure,
        "humidity": humidity,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}

class Sys {
  double message;
  String country;
  int sunrise;
  int sunset;

  Sys({
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => new Sys(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => new Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  double speed;
  double deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => new Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
