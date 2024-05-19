import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/widgets/weather_forecast_widget.dart';
import '../services/weather_service.dart';
import '../models/weather_response_model.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  Future<WeatherResponse>? _weather;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<WeatherResponse>(
          future: _weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final weatherResponse = snapshot.data!;
              // return weather Forecast widget
              return weatherForcastWidget(context, weatherResponse);
            } else if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error);
              }
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  // Function to fetch weather according to user's location
  Future<void> _getLocationAndWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String cityName = placemarks.first.locality ?? 'Unknown';

      if (kDebugMode) {
        print(
            "MY LOCATION: ${position.latitude}, ${position.longitude}, $cityName");
      }

      setState(() {
        _weather = WeatherService().getWeatherByLocation(cityName);
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error getting location: $e");
      }
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Access Denied'),
          content: const Text(
              'Please grant permission to access your device\'s location to fetch weather data.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
