import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class GetCurrentWeatherUseCase
    implements UseCase<CurrentWeatherEntity, LocationParams> {
  final WeatherRepository _repo;

  GetCurrentWeatherUseCase(this._repo);
  @override
  Future<Either<Failure, CurrentWeatherEntity>> call(LocationParams params) {
    return _repo.getCurrentWeather(params);
  }
}
