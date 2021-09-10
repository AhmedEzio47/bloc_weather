import 'package:bloc_weather/bloc/states/weather_state.dart';
import 'package:bloc_weather/data/models/weather.dart';
import 'package:bloc_weather/data/repos/weather_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Events { loading, ready, empty, request, error }

class WeatherEvent {
  Events event;
  dynamic data;
  WeatherEvent({this.event, this.data});
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState(isLoading: false, weather: null)) {
    this.add(WeatherEvent(
      event: Events.empty,
    ));
  }

  @override
  Stream<WeatherState> mapEventToState(event) async* {
    switch (event.event) {
      case Events.loading:
        yield WeatherState(isLoading: true, weather: null);
        break;

      case Events.ready:
        yield WeatherState(isLoading: false, weather: event.data);
        break;

      case Events.empty:
        yield WeatherState(
          isLoading: false,
        );
        break;

      case Events.request:
        this.add(WeatherEvent(event: Events.loading));
        Weather weather = await WeatherRepo().getWeather(event.data);
        if (weather != null)
          this.add(WeatherEvent(event: Events.ready, data: weather));
        else
          this.add(WeatherEvent(
            event: Events.error,
          ));

        break;

      case Events.error:
        yield WeatherState(isLoading: false, error: true);
        break;
    }
  }
}
