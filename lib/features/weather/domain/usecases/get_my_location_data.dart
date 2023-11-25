import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/local_location.dart';
import 'package:weather_app/features/weather/domain/repository/repository.dart';

class GetMyLocationDataUseCase extends UseCase<LocalLocationEntity, void> {
  final WeatherRepository _repo;

  GetMyLocationDataUseCase(this._repo);

  @override
  Future<Either<Failure, LocalLocationEntity>> call(void params) =>
      _repo.getLocalLocation();
}
