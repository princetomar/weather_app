import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather_response_model.dart';
import 'package:weatherapp/utils/api_constants.dart';

class WeatherService {
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/forecast';

  Future<WeatherResponse> getWeatherByLocation(String cityName) async {
    final response = await http.get(Uri.parse(
        '${baseUrl}?q=${cityName}&appid=${ApiConstants.OPEN_WEATHER_API_KEY}'));
    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      return WeatherResponse.fromJson(weatherData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
