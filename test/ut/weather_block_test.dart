import 'dart:async';

import 'package:airadar/blocs/weather_bloc.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/model/weather_forecast_state.dart';
import 'package:airadar/repo/mock/mock_place_api_response.dart';
import 'package:airadar/repo/mock/mock_weather_api_response.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalMockWeatherService extends Mock implements WeatherRepository {}

void main() {
  group('Weather Bloc', () {
    WeatherBloc bloc;
    LocalMockWeatherService api;

    setUp(() {
      api = LocalMockWeatherService();
      bloc = WeatherBloc(api);
    });

    test('emits loading state then valid suggestion state', () {
      final place = MockPlaceApiResponse.placeSuggestions.places[0];
      final forecast = MockWeatherApiResponse.weather1;
      setupWeatherMock(api, place, forecast);

      scheduleMicrotask(() {
        bloc.place.add(place);
      });

      expect(
        bloc.weatherStream,
        emitsInOrder([
          emits((WeatherForecastState item) => item.loading),
          emits((WeatherForecastState item) => isValidForecastState(item, forecast)),
        ]),
      );
    });

    test('switches query', () {
      final place1 = MockPlaceApiResponse.placeSuggestions.places[0];
      final forecast1 = MockWeatherApiResponse.weather1;
      setupWeatherMock(api, place1, forecast1);

      final place2 = MockPlaceApiResponse.placeSuggestions.places[1];
      final forecast2 = MockWeatherApiResponse.weather2;
      setupWeatherMock(api, place2, forecast2);

      scheduleMicrotask(() {
        bloc.place.add(place1);
        bloc.place.add(place2);
      });

      expect(
        bloc.weatherStream,
        emitsInOrder([
          emits((WeatherForecastState item) => item.loading),
          emits((WeatherForecastState item) => isValidForecastState(item, forecast2)),
        ]),
      );
    });

    test('emits error state when api throws an Exception', () {
      final place = MockPlaceApiResponse.placeSuggestions.places[0];
      when(api.getWeatherForecast(
        place.geometry.coordinates[0],
        place.geometry.coordinates[1],
      )).thenThrow(Exception());

      scheduleMicrotask(() {
        bloc.place.add(place);
      });

      expect(
        bloc.weatherStream,
        emitsInOrder([
          emits((WeatherForecastState item) => item.loading),
          emits((WeatherForecastState item) => item.error),
        ]),
      );
    });

    test('stream emits done when bloc is disposed', () {
      scheduleMicrotask(() {
        bloc.dispose();
      });

      expect(
        bloc.weatherStream,
        emitsInOrder([
          emitsDone,
        ]),
      );
    });
  });
}

void setupWeatherMock(LocalMockWeatherService mockApi, Place place, WeatherForecast forecast) {
  when(mockApi.getWeatherForecast(
    place.geometry.coordinates[0],
    place.geometry.coordinates[1],
  )).thenAnswer((_) async => forecast);
}

bool isValidForecastState(WeatherForecastState state, WeatherForecast forecast) {
  return state.weatherForecast == forecast && !state.loading && !state.error;
}
