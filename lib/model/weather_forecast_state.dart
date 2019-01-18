import 'package:airadar/model/weather_forecast.dart';

class WeatherForecastState {
  final bool loading;
  final bool error;
  final WeatherForecast weatherForecast;

  WeatherForecastState(
      {this.loading = false, this.error = false, this.weatherForecast});
}
