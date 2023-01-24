import 'package:flutter/material.dart';
import '../weather.dart';

Widget WeatherBox(Weather weather) {
  return FittedBox(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${weather.city}, ${weather.country}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            " ${(weather.temp).round()}º ",
            style: const TextStyle(fontSize: 68),
          ),
          Text(
            weather.description,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "  min.${(weather.low).round()}º  max.${(weather.high).round()}º ",
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
    ),
  );
}
