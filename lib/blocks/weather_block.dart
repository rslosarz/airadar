import 'package:airadar/model/place.dart';
import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/model/weather_forecast_state.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBlock {
  final WeatherRepository weatherRepository;

  Sink<Place> get place => _placeStream.sink;
  final _placeStream = BehaviorSubject<Place>();

  Stream<WeatherForecastState> weatherStream;

  WeatherBlock(this.weatherRepository) {
    weatherStream = _placeStream.switchMap(_getWeatherForecast);
  }

  void dispose() {
    _placeStream.close();
  }

  Stream<WeatherForecastState> _getWeatherForecast(Place place) async* {
    yield WeatherForecastState(loading: true);

    try {
      final double lat = place.geometry.coordinates[0];
      final double lon = place.geometry.coordinates[1];

      final weatherForecast =
          await weatherRepository.getWeatherForecast(lat, lon);
      yield WeatherForecastState(weatherForecast: weatherForecast);
    } catch (e) {
      yield WeatherForecastState(error: true);
    }
  }

  String getWeatherImageUrl(WeatherForecast weatherForecast) {
    return "http://openweathermap.org/img/w/${weatherForecast.weather[0].icon}.png";
  }
}
