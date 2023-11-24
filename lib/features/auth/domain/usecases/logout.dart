import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/auth/domain/repository/repository.dart';

class LogoutUseCase implements UseCase<void, void> {
  final AuthRepository _repo;

  LogoutUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(void params) => _repo.logout();
}
