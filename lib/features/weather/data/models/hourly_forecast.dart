import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app/features/weather/data/models/models.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast.dart';

class HourlyForecastModel extends HourlyForecastEntity {
  HourlyForecastModel({
    required super.list,
    required super.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'list': list,
      'city': (city as CityDetailsModel).toMap(),
    };
  }

  factory HourlyForecastModel.fromMap(Map<String, dynamic> map) {
    return HourlyForecastModel(
      list: List.from((map['list'] as List)
            .map((e) => ForecastDetailsModel.fromMap(e))
            .toList()),
      city: CityDetailsModel.fromMap(map['city']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyForecastModel.fromJson(String source) =>
      HourlyForecastModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HourlyForecastModel(list: $list, city: $city)';
  }
}

class CityDetailsModel extends CityDetails {
  CityDetailsModel({
    super.id,
    super.name,
    required super.timezone,
    super.sunrise,
    super.sunset,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory CityDetailsModel.fromMap(Map<String, dynamic> map) {
    return CityDetailsModel(
      id: map['id']?.toInt(),
      name: map['name'],
      timezone: map['timezone']?.toInt() ?? 0,
      sunrise: map['sunrise']?.toInt(),
      sunset: map['sunset']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CityDetailsModel.fromJson(String source) =>
      CityDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CityDetailsModel(id: $id, name: $name, timezone: $timezone, sunrise: $sunrise, sunset: $sunset)';
  }
}

class ForecastDetailsModel extends ForecastDetails {
  ForecastDetailsModel({
    required super.dt,
    required super.main,
    required super.weather,
  });

  ForecastDetailsModel copyWith({
    int? dt,
    CurrentWeatherDetailsModel? main,
    List<WeatherDescriptionAndIconModel>? weather,
  }) {
    return ForecastDetailsModel(
      dt: dt ?? this.dt,
      main: main ?? this.main,
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'main': (main as CurrentWeatherDetailsModel).toMap(),
      'weather': weather,
    };
  }

  factory ForecastDetailsModel.fromMap(Map<String, dynamic> map) {
    return ForecastDetailsModel(
      dt: map['dt']?.toInt() ?? 0,
      main: CurrentWeatherDetailsModel.fromMap(map['main']),
      weather: List<WeatherDescriptionAndIconModel>.from(map['weather']?.map((x) => WeatherDescriptionAndIconModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastDetailsModel.fromJson(String source) => ForecastDetailsModel.fromMap(json.decode(source));

  @override
  String toString() => 'ForecastDetailsModel(dt: $dt, main: $main, weather: $weather)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ForecastDetailsModel &&
      other.dt == dt &&
      other.main == main &&
      listEquals(other.weather, weather);
  }

  @override
  int get hashCode => dt.hashCode ^ main.hashCode ^ weather.hashCode;
}
