import 'package:airadar/model/weather_forecast.dart';

abstract class WeatherRepository {
  Future<WeatherForecast> getWeatherForecast(double lat, double lon);
}
