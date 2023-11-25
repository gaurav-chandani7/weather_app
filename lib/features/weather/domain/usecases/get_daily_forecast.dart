import 'package:dartz/dartz.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/domain/repository/repository.dart';

class GetDailyForecastUseCase
    extends UseCase<DailyForecastEntity, LocationParams> {
  final WeatherRepository _repo;

  GetDailyForecastUseCase(this._repo);
  @override
  Future<Either<Failure, DailyForecastEntity>> call(LocationParams params) =>
      _repo.getDailyForecast(params);
}
