import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/repo/weather_repository.dart';

class MockWeatherService implements WeatherRepository {
  final mockWeather = WeatherForecast(
    main: Main(
      temp: 23.0,
      pressure: 1000.0,
    ),
    wind: Wind(
      speed: 5.0,
      deg: 180.0,
    ),
    clouds: Clouds(
      all: 60,
    ),
    weather: [
      Weather(
        icon: "03d",
      ),
    ],
  );

  @override
  Future<WeatherForecast> getWeatherForecast(double lat, double lon) async {
    return mockWeather;
  }
}
