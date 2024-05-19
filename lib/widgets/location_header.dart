import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

Widget locationHeader(Weather weather) {
  return Text(
    weather.areaName ?? "Area Name",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );
}
