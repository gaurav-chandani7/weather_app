class CurrentWeatherEntity {
  final String? name;
  final int dt;
  final CoOrdinates coord;
  final CurrentWeatherDetails main;
  final int timezone;
  final num visibility;
  final List<WeatherDescriptionAndIcon> weather;
  const CurrentWeatherEntity({
    this.name,
    required this.dt,
    required this.coord,
    required this.main,
    required this.timezone,
    required this.visibility,
    required this.weather
  });
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

// {
//     "coord": {
//         "lon": 78.8481,
//         "lat": 20.5517
//     },
//     "weather": [
//         {
//             "id": 802,
//             "main": "Clouds",
//             "description": "scattered clouds",
//             "icon": "03d"
//         }
//     ],
//     "base": "stations",
//     "main": {
//         "temp": 28.87,
//         "feels_like": 28.39,
//         "temp_min": 28.87,
//         "temp_max": 28.87,
//         "pressure": 1015,
//         "humidity": 39,
//         "sea_level": 1015,
//         "grnd_level": 990
//     },
//     "visibility": 10000,
//     "wind": {
//         "speed": 3.8,
//         "deg": 69,
//         "gust": 3.91
//     },
//     "clouds": {
//         "all": 37
//     },
//     "dt": 1700891267,
//     "sys": {
//         "country": "IN",
//         "sunrise": 1700874015,
//         "sunset": 1700913777
//     },
//     "timezone": 19800,
//     "id": 1270077,
//     "name": "Hinganghāt",
//     "cod": 200
// }