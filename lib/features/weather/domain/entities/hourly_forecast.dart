import 'package:weather_app/features/weather/domain/entities/current_weather.dart';

class HourlyForecastEntity {
  final List<ForecastDetails> list;
  final CityDetails city;
  const HourlyForecastEntity({
    required this.list,
    required this.city,
  });
}

class CityDetails {
  final int? id;
  final String? name;
  final int timezone;
  final int? sunrise;
  final int? sunset;
  const CityDetails({
    this.id,
    this.name,
    required this.timezone,
    this.sunrise,
    this.sunset,
  });
}

class ForecastDetails {
  final int dt;
  final CurrentWeatherDetails main;
  final List<WeatherDescriptionAndIcon> weather;
  ForecastDetails({
    required this.dt,
    required this.main,
    required this.weather,
  });
}
