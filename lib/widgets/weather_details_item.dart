import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String detail;

  WeatherDetailItem({
    required this.icon,
    required this.value,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        Text(
          detail,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
