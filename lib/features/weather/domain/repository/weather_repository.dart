import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';

abstract class WeatherRepository {
  Future<Either<Failure, LocalLocationEntity>> getLocalLocation();
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
      LocationParams locationParams);
}
