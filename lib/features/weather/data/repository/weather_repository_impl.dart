import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/data/data_sources/location_data_source.dart';
import 'package:weather_app/features/weather/data/data_sources/open_weather_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/current_weather.dart';
import 'package:weather_app/features/weather/domain/entities/daily_forecast.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast.dart';
import 'package:weather_app/features/weather/domain/entities/local_location.dart';
import 'package:weather_app/features/weather/domain/entities/location_params.dart';
import 'package:weather_app/features/weather/domain/repository/repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final LocationDataSource _locationDataSource;
  final OpenWeatherMapDataSource _openWeatherMapDataSource;

  WeatherRepositoryImpl(
      this._openWeatherMapDataSource, this._locationDataSource);

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
      LocationParams locationParams) {
    return _openWeatherMapDataSource.getCurrentWeather(locationParams);
  }

  @override
  Future<Either<Failure, LocalLocationEntity>> getLocalLocation() async {
    var res = await _locationDataSource.getLocalLocationData();
    return res.fold((l) => Left(l), (locData) {
      if (locData.latitude != null && locData.longitude != null) {
        return Right(LocalLocationEntity(
            latitude: locData.latitude!, longitude: locData.longitude!));
      }
      return const Left(OtherFailure(message: 'Invalid location data'));
    });
  }

  @override
  Future<Either<Failure, HourlyForecastEntity>> getHourlyForecast(
      LocationParams locationParams) {
    return _openWeatherMapDataSource.getHourlyForecast(locationParams);
  }

  @override
  Future<Either<Failure, DailyForecastEntity>> getDailyForecast(
      LocationParams locationParams) {
    return _openWeatherMapDataSource.getDailyForecast(locationParams);
  }
}
