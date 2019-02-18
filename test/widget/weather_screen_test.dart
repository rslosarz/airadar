import 'package:airadar/blocks/weather_block.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/repo/weather_repository.dart';
import 'package:airadar/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';

class MockWeatherService extends Mock implements WeatherRepository {}

void main() {
  group('WeatherScreen', () {
    WeatherRepository repo;
    final place = Place(
      properties: Properties(name: "Poznan"),
      geometry: Geometry(
        coordinates: [1.0, 2.0],
      ),
    );

    final forecast = WeatherForecast(
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

    setUpAll(() {
      repo = MockWeatherService();
      when(repo.getWeatherForecast(
        place.geometry.coordinates[0],
        place.geometry.coordinates[1],
      )).thenAnswer((_) async => forecast);
      final injector = Injector.getInjector();
      injector.map<WeatherRepository>((i) => repo, isSingleton: true);
      injector.map<WeatherBlock>(
          (i) => new WeatherBlock(injector.get<WeatherRepository>()));
    });

    testWidgets('displays weather forecast and place details',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await prepareWidget(tester, WeatherScreen(place));
        //needs to be pumped manually, as Flutter test lib forces manual state organizing
        await tester.pump();

        expect(find.text(place.properties.name), findsOneWidget);
        expect(find.byType(Image), findsNWidgets(2));
        expect(find.text("${forecast.main.temp.toStringAsFixed(0)} \u00b0C"),
            findsOneWidget);
        expect(find.text("${forecast.main.pressure.toStringAsFixed(0)} hPa"),
            findsOneWidget);
        expect(find.text("${forecast.wind.speed.toStringAsFixed(2)} m/s"),
            findsOneWidget);
        expect(find.text("${forecast.wind.deg.toStringAsFixed(0)} \u00b0"),
            findsOneWidget);
      });
    });
  });
}

void prepareWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    ),
  );
}
