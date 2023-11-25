import 'dart:convert';

import 'package:weather_app/features/weather/domain/entities/entities.dart';

class CurrentWeatherModel extends CurrentWeatherEntity {
  const CurrentWeatherModel(
      {String? name,
      required int dt,
      required CoOrdinatesModel coord,
      required CurrentWeatherDetailsModel main,
      required int timezone,
      required num visibility,
      required List<WeatherDescriptionAndIconModel> weather})
      : super(
            name: name,
            dt: dt,
            coord: coord,
            main: main,
            timezone: timezone,
            visibility: visibility,
            weather: weather);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dt': dt,
      'coord': (coord as CoOrdinatesModel).toMap(),
      'main': (main as CurrentWeatherDetailsModel).toMap(),
      'timezone': timezone,
      'visibility': visibility,
      'weather': (weather as WeatherDescriptionAndIconModel).toMap()
    };
  }

  factory CurrentWeatherModel.fromMap(Map<String, dynamic> map) {
    return CurrentWeatherModel(
        name: map['name'],
        dt: map['dt'] ?? 0,
        coord: CoOrdinatesModel.fromMap(map['coord']),
        main: CurrentWeatherDetailsModel.fromMap(map['main']),
        timezone: map['timezone'] ?? 0,
        visibility: map['visibility'] ?? 0,
        weather: List.from((map['weather'] as List)
            .map((e) => WeatherDescriptionAndIconModel.fromMap(e))
            .toList()));
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeatherModel.fromJson(String source) =>
      CurrentWeatherModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurrentWeatherModel(name: $name, dt: $dt, coord: $coord, main: $main, timezone: $timezone, visibility: $visibility, weather: $weather)';
  }
}

class CoOrdinatesModel extends CoOrdinates {
  CoOrdinatesModel({
    required double lon,
    required double lat,
  }) : super(lon: lon, lat: lat);

  Map<String, dynamic> toMap() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }

  factory CoOrdinatesModel.fromMap(Map<String, dynamic> map) {
    return CoOrdinatesModel(
      lon: map['lon']?.toDouble() ?? 0.0,
      lat: map['lat']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoOrdinatesModel.fromJson(String source) =>
      CoOrdinatesModel.fromMap(json.decode(source));

  @override
  String toString() => 'CoOrdinatesModel(lon: $lon, lat: $lat)';
}

class CurrentWeatherDetailsModel extends CurrentWeatherDetails {
  CurrentWeatherDetailsModel(
      {required super.temp,
      required super.feelsLike,
      required super.humidity,
      super.tempMin,
      super.tempMax});

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'humidity': humidity,
    };
  }

  factory CurrentWeatherDetailsModel.fromMap(Map<String, dynamic> map) {
    return CurrentWeatherDetailsModel(
      temp: map['temp']?.toDouble() ?? 0.0,
      feelsLike: map['feels_like']?.toDouble() ?? 0.0,
      tempMin: map['temp_min']?.toDouble(),
      tempMax: map['temp_max']?.toDouble(),
      humidity: map['humidity']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeatherDetailsModel.fromJson(String source) =>
      CurrentWeatherDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurrentWeatherDetailsModel(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, humidity: $humidity)';
  }
}

class WeatherDescriptionAndIconModel extends WeatherDescriptionAndIcon {
  WeatherDescriptionAndIconModel({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) : super(id: id, main: main, description: description, icon: icon);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherDescriptionAndIconModel.fromMap(Map<String, dynamic> map) {
    return WeatherDescriptionAndIconModel(
      id: map['id']?.toInt(),
      main: map['main'],
      description: map['description'],
      icon: map['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDescriptionAndIconModel.fromJson(String source) =>
      WeatherDescriptionAndIconModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WeatherDescriptionAndIconModel(id: $id, main: $main, description: $description, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherDescriptionAndIconModel &&
        other.id == id &&
        other.main == main &&
        other.description == description &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^ main.hashCode ^ description.hashCode ^ icon.hashCode;
  }
}
