import 'dart:async';
import 'dart:convert';

import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:http/http.dart' as http;

class WeatherService implements WeatherRepository {
  final weatherUrl = "api.openweathermap.org";
  final apiPath = "/data/2.5/weather";
  final appId = "917069d422e9405fb364f5495a1dd71c";
  final http.Client client;

  WeatherService(this.client);

  @override
  Future<WeatherForecast> getWeatherForecast(double lat, double lon) async {
    final url = Uri.http(weatherUrl, apiPath, {
      "lat": lat.toString(),
      "lon": lon.toString(),
      "APPID": appId,
      "units": "metric"
    });
    print(url.toString());
    final response = await client.get(url);

    return WeatherForecast.fromJson(json.decode(response.body));
  }
}

