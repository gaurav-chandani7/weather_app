

import 'package:weather_app/features/weather/domain/entities/entities.dart';

class DailyForecastEntity {
  CityDetails city;
  List<DayForecastDetails> list;
  DailyForecastEntity({
    required this.city,
    required this.list,
  });
}

class DayForecastDetails {
  int dt;
  int? sunrise;
  int? sunset;
  TempDetailsDayForecast temp;
  double pressure;
  double humidity;
  List<WeatherDescriptionAndIcon> weather;
  DayForecastDetails({
    required this.dt,
    this.sunrise,
    this.sunset,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.weather,
  });
}

class TempDetailsDayForecast {
  double? day;
  double min;
  double max;
  double? night;
  double? eve;
  double? morn;
  TempDetailsDayForecast({
    this.day,
    required this.min,
    required this.max,
    this.night,
    this.eve,
    this.morn,
  });
}
