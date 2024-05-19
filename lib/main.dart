import 'package:flutter/material.dart';
import 'package:weatherapp/screens/map_screen.dart';
import 'package:weatherapp/screens/weather_forecast_screen.dart';
import 'package:weatherapp/utils/navigation_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: NavigationConstants.forecastScreen,
      routes: {
        NavigationConstants.forecastScreen: (context) => ForecastScreen(),
        NavigationConstants.mapScreen: (context) => MapScreen(),
      },
    );
  }
}
