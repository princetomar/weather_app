import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDayItem extends StatelessWidget {
  final String day;
  final String temperature;
  final String description;

  WeatherDayItem({
    required this.day,
    required this.temperature,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: GoogleFonts.lato(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          Row(
            children: [
              Text(
                description,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              SizedBox(width: 10),
              Text(
                temperature,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
