import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast.dart';

abstract class WeatherRepository {
  Future<Either<Failure, LocalLocationEntity>> getLocalLocation();
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
      LocationParams locationParams);
  Future<Either<Failure, HourlyForecastEntity>> getHourlyForecast(
      LocationParams locationParams);
}
