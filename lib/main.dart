import 'package:flutter/material.dart';
import 'package:weather_app/Screens/currentWeather.dart';
 void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "weather app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CurrentWeatherPage() ,
    );
  }
}