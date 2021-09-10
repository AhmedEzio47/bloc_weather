import 'package:bloc_weather/constants.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  Future<http.Response> getWeatherData(String city) async {
    try {
      var response = await http.get(Uri.parse(kWeatherAPIUrl(city)));
      return response;
    } catch (ex) {
      return null;
    }
  }
}
