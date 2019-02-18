import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/repo/weather_repository.dart';

class MockWeatherService implements WeatherRepository {
  final mockWeather = WeatherForecast(
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

  @override
  Future<WeatherForecast> getWeatherForecast(double lat, double lon) async {
    return mockWeather;
  }
}
