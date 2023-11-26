import 'package:flutter/material.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast.dart';

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({super.key, required this.hourlyForecast});
  final HourlyForecastEntity hourlyForecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Container(
        height: 170,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.brown.shade200,
            boxShadow: kElevationToShadow[3],
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "HOURLY FORECAST",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              indent: 8,
              endIndent: 8,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hourlyForecast.list.length,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    var item = hourlyForecast.list[index];
                    var date =
                        DateTime.fromMillisecondsSinceEpoch(item.dt * 1000);
                    var hour = (date.hour == 0 || date.hour == 12)
                        ? 12
                        : (date.hour % 12);
                    var ampm = (date.hour == 0 || date.hour < 12) ? 'AM' : 'PM';
                    return SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                                text: index != 0 ? '$hour' : 'Now',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                                children: index != 0
                                    ? [
                                        TextSpan(
                                            text: ampm,
                                            style:
                                                const TextStyle(fontSize: 12))
                                      ]
                                    : null),
                          ),
                          Image.network(
                              "$iconBaseUrl/${item.weather.first.icon}.png"),
                          Text("${item.main.temp.round()}°")
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
