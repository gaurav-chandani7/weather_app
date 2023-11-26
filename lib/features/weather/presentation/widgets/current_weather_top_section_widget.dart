import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/current_weather.dart';

class CurrentWeatherTopSectionWidget extends StatelessWidget {
  const CurrentWeatherTopSectionWidget({
    super.key,
    required this.currentWeather,
  });

  final CurrentWeatherEntity currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          currentWeather.name ?? 'Unknown Location',
          style: const TextStyle(fontSize: 30),
        ),
        Text(
          "${currentWeather.main.temp.round()}°C",
          style: const TextStyle(fontSize: 32),
        ),
        Row(
          children: [
            Image(
              image: NetworkImage(
                  "https://openweathermap.org/img/wn/${currentWeather.weather.first.icon}@4x.png"),
            ),
            Column(
              children: [
                currentWeather.weather.first.main != null
                    ? Text(
                        currentWeather.weather.first.main!,
                        style: const TextStyle(fontSize: 19),
                      )
                    : const SizedBox(),
                (currentWeather.main.tempMin != null &&
                        currentWeather.main.tempMax != null)
                    ? Text(
                        "H:${currentWeather.main.tempMin!.round()}° L:${currentWeather.main.tempMax!.round()}°",
                        style: const TextStyle(fontSize: 19),
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Humidity",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "${currentWeather.main.humidity.round()}%",
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              const Divider(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Feels like",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "${currentWeather.main.feelsLike.round()}°",
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
              const Divider(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Visibility",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "${(currentWeather.visibility / 1000).round()} km",
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}