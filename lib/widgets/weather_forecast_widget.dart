import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/weather_response_model.dart';
import 'package:weatherapp/utils/navigation_constants.dart';
import 'package:weatherapp/widgets/weather_details_item.dart';

Widget weatherForcastWidget(
    BuildContext context, WeatherResponse weatherResponse) {
  final icon = weatherResponse.list.isNotEmpty
      ? weatherResponse.list[0].weather[0].icon ?? ''
      : '';

  final temperature = weatherResponse.list.isNotEmpty
      ? weatherResponse.list[0].main?.temp ?? 0
      : 0;
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.deepPurpleAccent, Colors.black],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              Text(
                weatherResponse.city?.name ?? '',
                style: GoogleFonts.lato(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Hello There,',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${(temperature - 273.15).toStringAsFixed(1)} °C',
                        style: GoogleFonts.lato(
                          fontSize: 64,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        weatherResponse.list.isNotEmpty
                            ? weatherResponse.list[0].weather[0].description ??
                                ''
                            : ''.toUpperCase(),
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, d MMMM').format(DateTime.now()),
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  if (icon.isNotEmpty)
                    Image.network(
                      'https://openweathermap.org/img/wn/$icon@2x.png',
                      scale: 0.9,
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(
                thickness: 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherDetailItem(
                    icon: Icons.wb_sunny_outlined,
                    value: 'Sunrise',
                    detail: DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        (weatherResponse.city!.sunrise! * 1000).toInt(),
                      ),
                    ),
                  ),
                  WeatherDetailItem(
                    icon: Icons.brightness_3_outlined,
                    value: 'Sunset',
                    detail: DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        (weatherResponse.city!.sunset! * 1000).toInt(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherDetailItem(
                    icon: Icons.cloud_outlined,
                    value: 'Air Quality',
                    detail: '${weatherResponse.list[0].main?.humidity} %',
                  ),
                  WeatherDetailItem(
                    icon: Icons.water_drop_outlined,
                    value: 'Humidity',
                    detail: '${weatherResponse.list[0].main?.humidity} %',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherDetailItem(
                    icon: Icons.grain,
                    value: 'Pressure',
                    detail: '${weatherResponse.list[0].main!.pressure!}%',
                  ),
                  WeatherDetailItem(
                    icon: Icons.thermostat_outlined,
                    value: 'Clouds',
                    detail: '${weatherResponse.list[0].clouds!.all!}%',
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Your forecast screen content here
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, NavigationConstants.mapScreen);
                      },
                      child: Text('Go to Map Screen'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
