import 'package:airadar/blocs/weather_bloc.dart';
import 'package:airadar/model/place.dart';
import 'package:airadar/model/weather_forecast.dart';
import 'package:airadar/model/weather_forecast_state.dart';
import 'package:airadar/utils/resource_manager.dart';
import 'package:airadar/widgets/fetch_error_widget.dart';
import 'package:airadar/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class WeatherScreen extends StatefulWidget {
  final Place place;

  WeatherScreen(this.place);

  @override
  State<StatefulWidget> createState() {
    return WeatherScreenState(
        place, Injector.getInjector().get<WeatherBloc>());
  }
}

class WeatherScreenState extends State<WeatherScreen> {
  final Place place;
  WeatherBloc weatherBloc;

  WeatherScreenState(this.place, this.weatherBloc);

  @override
  void initState() {
    super.initState();
    weatherBloc.place.add(place);
  }

  @override
  void dispose() {
    weatherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in ${place.properties.name}'),
      ),
      body: Column(
        children: <Widget>[
          _buildPlaceDescriptionPart(),
          _buildWeatherPart(),
        ],
      ),
    );
  }

  Widget _buildPlaceDescriptionPart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: place.properties.hashCode,
              child: Image.asset(
                ResourceManager.getPlaceImageAsset(place),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                place.properties.name,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherPart() {
    return StreamBuilder<WeatherForecastState>(
      initialData: WeatherForecastState(),
      stream: weatherBloc.weatherStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return Expanded(
          child: _buildStateWidget(context, state),
        );
      },
    );
  }

  Widget _buildStateWidget(BuildContext context, WeatherForecastState state) {
    if (state.loading) {
      return LoadingWidget();
    } else if (state.error) {
      return FetchErrorWidget();
    } else if (state.weatherForecast == null) {
      return _emptyListWidget();
    } else {
      return _buildWeatherChart(context, state.weatherForecast);
    }
  }

  Widget _buildWeatherChart(
      BuildContext context, WeatherForecast weatherForecast) {
    return ListView(
      children: <Widget>[
        _buildWeatherSummary(context, weatherForecast),
        _buildWindSummary(context, weatherForecast),
        _buildCloudsSummary(context, weatherForecast)
      ],
    );
  }

  Widget _emptyListWidget() {
    return Container(
      child: Text(
        'No data',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
    );
  }

  Widget _buildWeatherSummary(
      BuildContext context, WeatherForecast weatherForecast) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipOval(
            child: Container(
              color: Colors.white,
              child: Image.network(
                weatherBloc.getWeatherImageUrl(weatherForecast),
                width: 64.0,
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text('Temp'),
                  Text(
                      "${weatherForecast.main.temp.toStringAsFixed(0)} \u00b0C"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text('Pressure'),
                  Text(
                      "${weatherForecast.main.pressure.toStringAsFixed(0)} hPa"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWindSummary(
      BuildContext context, WeatherForecast weatherForecast) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
      child: Column(
        children: <Widget>[
          Text(
            'Wind Details',
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Speed'),
                    Text(
                        "${weatherForecast.wind.speed.toStringAsFixed(2)} m/s"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Direction'),
                    Text(
                        "${weatherForecast.wind.deg.toStringAsFixed(0)} \u00b0"),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCloudsSummary(
      BuildContext context, WeatherForecast weatherForecast) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
      child: Column(
        children: <Widget>[
          Text(
            'Cloud Details',
            style: TextStyle(fontSize: 18.0),
          ),
          Column(
            children: <Widget>[
              Text('Covarage'),
              Text("${weatherForecast.clouds.all} %"),
            ],
          )
        ],
      ),
    );
  }
}
