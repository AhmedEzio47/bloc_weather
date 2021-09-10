import 'package:bloc_weather/data/models/weather.dart';
import 'package:bloc_weather/data/providers/weather_provider.dart';

class WeatherRepo {
  final WeatherAPI _weatherAPI = WeatherAPI();
  Future<Weather> getWeather(String city) async {
    var rawWeatherData = await _weatherAPI.getWeatherData(city);
    return rawWeatherData.statusCode == 200
        ? Weather.fromOpenWeatherJson(rawWeatherData.body)
        : null;
  }
}
