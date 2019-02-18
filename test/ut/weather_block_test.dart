import 'dart:async';

import 'package:airadar/blocks/weather_block.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/model/weather_forecast_state.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockWeatherService extends Mock implements WeatherRepository {}

void main() {
  group('Weather Block', () {
    WeatherBlock block;
    MockWeatherService api;

    setUp(() {
      api = MockWeatherService();
      block = WeatherBlock(api);
    });

    tearDown(() {
      api = null;
      block = null;
    });

    test('emits loading state then valid suggestion state', () {
      final place = Place(geometry: Geometry(coordinates: [1.0, 2.0]));
      final forecast =
          WeatherForecast(main: Main(temp: 128.0, pressure: 123.0));
      when(api.getWeatherForecast(
        place.geometry.coordinates[0],
        place.geometry.coordinates[1],
      )).thenAnswer((_) async => forecast);

      scheduleMicrotask(() {
        block.place.add(place);
      });

      expect(
        block.weatherStream,
        emitsInOrder([
          emits((WeatherForecastState item) => item.loading),
          emits((WeatherForecastState item) =>
              isValidForecastState(item, forecast)),
        ]),
      );
    });

    test('switches query', () {
      final place1 = Place(geometry: Geometry(coordinates: [1.0, 2.0]));
      final forecast1 =
          WeatherForecast(main: Main(temp: 128.0, pressure: 123.0));

      final place2 = Place(geometry: Geometry(coordinates: [3.0, 4.0]));
      final forecast2 =
          WeatherForecast(main: Main(temp: 231.0, pressure: 231.0));

      when(api.getWeatherForecast(
        place1.geometry.coordinates[0],
        place1.geometry.coordinates[1],
      )).thenAnswer((_) async => forecast1);

      when(api.getWeatherForecast(
        place2.geometry.coordinates[0],
        place2.geometry.coordinates[1],
      )).thenAnswer((_) async => forecast2);

      scheduleMicrotask(() {
        block.place.add(place1);
        block.place.add(place2);
      });

      expect(
        block.weatherStream,
        emitsInOrder([
          emits((WeatherForecastState item) => item.loading),
          emits((WeatherForecastState item) =>
              isValidForecastState(item, forecast2)),
        ]),
      );
    });

    test('emits error state when api throws an Exception', () {
      final place = Place(geometry: Geometry(coordinates: [1.0, 2.0]));
      when(api.getWeatherForecast(
        place.geometry.coordinates[0],
        place.geometry.coordinates[1],
      )).thenThrow(Exception());

      scheduleMicrotask(() {
        block.place.add(place);
      });

      expect(
        block.weatherStream,
        emitsInOrder([
          emits((WeatherForecastState item) => item.loading),
          emits((WeatherForecastState item) => item.error),
        ]),
      );
    });

    test('stream emits done when block is disposed', () {
      scheduleMicrotask(() {
        block.dispose();
      });

      expect(
        block.weatherStream,
        emitsInOrder([
          emitsDone,
        ]),
      );
    });
  });
}

bool isValidForecastState(
    WeatherForecastState state, WeatherForecast forecast) {
  return state.weatherForecast == forecast && !state.loading && !state.error;
}
