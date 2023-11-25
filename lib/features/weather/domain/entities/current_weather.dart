class CurrentWeatherEntity {
  final String? name;
  final int dt;
  final CoOrdinates coord;
  final CurrentWeatherDetails main;
  final int timezone;
  final num visibility;
  final List<WeatherDescriptionAndIcon> weather;
  const CurrentWeatherEntity(
      {this.name,
      required this.dt,
      required this.coord,
      required this.main,
      required this.timezone,
      required this.visibility,
      required this.weather});
}

class CoOrdinates {
  final double lon;
  final double lat;
  const CoOrdinates({
    required this.lon,
    required this.lat,
  });
}

class CurrentWeatherDetails {
  final double temp;
  final double feelsLike;
  final double? tempMin;
  final double? tempMax;
  final double humidity;
  const CurrentWeatherDetails({
    required this.temp,
    required this.feelsLike,
    this.tempMin,
    this.tempMax,
    required this.humidity,
  });
}

class WeatherDescriptionAndIcon {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherDescriptionAndIcon({this.id, this.main, this.description, this.icon});
}
