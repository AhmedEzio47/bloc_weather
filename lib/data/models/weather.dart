import 'dart:convert';

class Weather {
  String description;
  int temperature;
  int pressure;
  int humidity;
  Weather({this.description, this.temperature, this.pressure, this.humidity});
  factory Weather.fromOpenWeatherJson(String json) {
    var decodedJson = jsonDecode(json);
    return Weather(
      description: decodedJson['weather'][0]['description'],
      temperature: (decodedJson['main']['temp'] - 273.0).round(),
      pressure: decodedJson['main']['pressure'],
      humidity: decodedJson['main']['humidity'],
    );
  }
}
