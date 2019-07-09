import 'package:airadar/model/weather_forecast.dart';

class MockWeatherApiResponse {

  static final weather1 = WeatherForecast(
    coord: Coord(lat: 123, lon: 54,),
    weather: [
      Weather(
        id: 800,
        main: "Clear",
        description: "clear sky",
        icon: "01n",
      ),
    ],
    main: Main(
      temp: 23.0,
      pressure: 1000.0,
      humidity: 55,
      tempMin: -21.11,
      tempMax: 21.11,
      seaLevel: 1046.78,
      grndLevel: 979.46,
    ),
    wind: Wind(
      speed: 1.06,
      deg: 261.002,
    ),
    clouds: Clouds(
      all: 60,
    ),
    sys: Sys(
      message: 0.0028,
      country: "RU",
      sunrise: 1548373590,
      sunset: 1548404079,
    ),
    id: 2014078,
    name: "Urusha",
    cod: 200,
  );

  static final weather2 = WeatherForecast(
    coord: Coord(lat: 52, lon: 43,),
    weather: [
      Weather(
        id: 500,
        main: "Rain",
        description: "light rain",
        icon: "10d",
      ),
    ],
    main: Main(
      temp: 34.0,
      pressure: 1005.83,
      humidity: 86,
      tempMin: 4.79,
      tempMax: 7.34,
      seaLevel: 1015.78,
      grndLevel: 1005.83,
    ),
    wind: Wind(
      speed: 10.41,
      deg: 286.501,
    ),
    clouds: Clouds(
      all: 88,
    ),
    sys: Sys(
      message: 0.0033,
      country: "KZ",
      sunrise: 1550460313,
      sunset: 1550498832,
    ),
    id: 609919,
    name: "Kuryk",
    cod: 200,
  );

  static final weatherResponse = """{
    "coord": {
        "lon": 123,
        "lat": 54
    },
    "weather": [
        {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
        }
    ],
    "base": "stations",
    "main": {
        "temp": -21.11,
        "pressure": 979.46,
        "humidity": 55,
        "temp_min": -21.11,
        "temp_max": -21.11,
        "sea_level": 1046.78,
        "grnd_level": 979.46
    },
    "wind": {
        "speed": 1.06,
        "deg": 261.002
    },
    "clouds": {
        "all": 0
    },
    "dt": 1548412330,
    "sys": {
        "message": 0.0028,
        "country": "RU",
        "sunrise": 1548373590,
        "sunset": 1548404079
    },
    "id": 2014078,
    "name": "Urusha",
    "cod": 200
}
  """;

  static final weatherErrorResponse = """{
    "cod": "400",
    "message": "91 is not a float"
}""";
}
