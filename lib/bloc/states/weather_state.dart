import 'package:bloc_weather/data/models/weather.dart';

class WeatherState {
  bool isLoading;
  Weather weather;
  bool error;
  WeatherState({this.weather, this.isLoading, this.error = false});
}
