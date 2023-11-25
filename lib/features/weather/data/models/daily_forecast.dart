import 'dart:convert';

import 'package:weather_app/features/weather/data/models/models.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';

class DailyForecastModel extends DailyForecastEntity {
  DailyForecastModel({
    required super.city,
    required super.list,
  });

  Map<String, dynamic> toMap() {
    return {
      'city': (city as CityDetailsModel).toMap(),
      'list': (list as List<DayForecastDetailsModel>).map((x) => x.toMap()).toList(),
    };
  }

  factory DailyForecastModel.fromMap(Map<String, dynamic> map) {
    return DailyForecastModel(
      city: CityDetailsModel.fromMap(map['city']),
      list: List<DayForecastDetailsModel>.from(map['list']?.map((x) => DayForecastDetailsModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyForecastModel.fromJson(String source) => DailyForecastModel.fromMap(json.decode(source));

  @override
  String toString() => 'DailyForecastModel(city: $city, list: $list)';
}

class DayForecastDetailsModel extends DayForecastDetails {
  DayForecastDetailsModel({
    required super.dt,
    super.sunrise,
    super.sunset,
    required super.temp,
    required super.pressure,
    required super.humidity,
    required super.weather,
  });

  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': (temp as TempDetailsDayForecastModel).toMap(),
      'pressure': pressure,
      'humidity': humidity,
      'weather': (weather as List<WeatherDescriptionAndIconModel>)
          .map((x) => x.toMap())
          .toList(),
    };
  }

  factory DayForecastDetailsModel.fromMap(Map<String, dynamic> map) {
    return DayForecastDetailsModel(
      dt: map['dt']?.toInt() ?? 0,
      sunrise: map['sunrise']?.toInt(),
      sunset: map['sunset']?.toInt(),
      temp: TempDetailsDayForecastModel.fromMap(map['temp']),
      pressure: map['pressure']?.toDouble() ?? 0.0,
      humidity: map['humidity']?.toDouble() ?? 0.0,
      weather: List<WeatherDescriptionAndIconModel>.from(map['weather']
          ?.map((x) => WeatherDescriptionAndIconModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DayForecastDetailsModel.fromJson(String source) =>
      DayForecastDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DayForecastDetailsModel(dt: $dt, sunrise: $sunrise, sunset: $sunset, temp: $temp, pressure: $pressure, humidity: $humidity, weather: $weather)';
  }
}

class TempDetailsDayForecastModel extends TempDetailsDayForecast {
  TempDetailsDayForecastModel({
    super.day,
    required super.min,
    required super.max,
    super.night,
    super.eve,
    super.morn,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'min': min,
      'max': max,
      'night': night,
      'eve': eve,
      'morn': morn,
    };
  }

  factory TempDetailsDayForecastModel.fromMap(Map<String, dynamic> map) {
    return TempDetailsDayForecastModel(
      day: map['day']?.toDouble(),
      min: map['min']?.toDouble() ?? 0.0,
      max: map['max']?.toDouble() ?? 0.0,
      night: map['night']?.toDouble(),
      eve: map['eve']?.toDouble(),
      morn: map['morn']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TempDetailsDayForecastModel.fromJson(String source) =>
      TempDetailsDayForecastModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TempDetailsDayForecastModel(day: $day, min: $min, max: $max, night: $night, eve: $eve, morn: $morn)';
  }
}
