import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/Models/weather.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherPage extends StatefulWidget {
  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  late Weather _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _weather = snapshot.data;
              if (_weather == null) {
                return const Text('Error in getting weather');
              } else {
                return weatherBox(_weather);
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }
}

Widget weatherBox(Weather _weather) {

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [

      Container(
        margin: const EdgeInsets.all(10.0),
        child: Text(
          '${_weather.temp}°C',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
        ),
      ),

      Container(
        margin: const EdgeInsets.all(5.0),
        child: Text('${_weather.description}')
        ),

      Container(
        margin: const EdgeInsets.all(5.0),
        child: Text('Feels:${_weather.feelsLike}°C')
        ),

      Container(
        margin: const EdgeInsets.all(5.0),
        child: Text('H:${_weather.high}°C L:${_weather.low}°C')
        ),
    ],
  );
}

Future getCurrentWeather() async {
  late Weather weather;
  String city = 'kolkata';
  String apiKey = 'a97d3b1549a4ea5d23ce92f6f68d1cb8';
  var url =
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

      Uri uri = Uri.parse(url);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {
    const Text('Failed');
  }
  return weather;
}
