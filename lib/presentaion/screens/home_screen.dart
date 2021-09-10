import 'package:bloc_weather/bloc/blocs/weather_bloc.dart';
import 'package:bloc_weather/bloc/states/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(hintText: 'City name'),
                ),
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => BlocProvider.of<WeatherBloc>(context).add(
                    WeatherEvent(
                        event: Events.request,
                        data: _textEditingController.text)),
                child: Text('Fetch Weather'),
              ),
              if (state?.isLoading ?? false) CircularProgressIndicator(),
              if (state?.error ?? false) Text('Error occurred'),
              if (state.weather != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Description: ${state.weather.description}'),
                    Text('Temperature: ${state.weather.temperature}'),
                    Text('Humidity: ${state.weather.humidity}'),
                    Text('Pressure: ${state.weather.pressure}'),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
