import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast.dart';
import 'package:weather_app/features/weather/domain/repository/repository.dart';

class GetHourlyForecast
    implements UseCase<HourlyForecastEntity, LocationParams> {
  final WeatherRepository _repo;

  GetHourlyForecast(this._repo);
  @override
  Future<Either<Failure, HourlyForecastEntity>> call(LocationParams params) =>
      _repo.getHourlyForecast(params);
}
