import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/daily_forecast.dart';

class DailyForecastWidget extends StatelessWidget {
  const DailyForecastWidget({super.key, required this.dailyForecast});
  final DailyForecastEntity dailyForecast;
  final List<String> weekdays3letterlist = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Container(
        height: 420,
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
                    Icons.calendar_month,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "7-DAY FORECAST",
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dailyForecast.list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = dailyForecast.list[index];
                    var date =
                        DateTime.fromMillisecondsSinceEpoch(item.dt * 1000);
                    var formattedDay = weekdays3letterlist[date.weekday - 1];
                    return SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            index == 0 ? 'Today' : formattedDay,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Image.network(
                              "https://openweathermap.org/img/wn/${item.weather.first.icon}.png"),
                          Text(
                            "${item.temp.min.round()}° - ${item.temp.max.round()}°",
                            style: const TextStyle(fontSize: 15),
                          )
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
