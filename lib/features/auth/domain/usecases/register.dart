import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';
import 'package:weather_app/features/auth/domain/repository/repository.dart';

class RegisterUseCase implements UseCase<UserLoginInfo, RegisterParams> {
  final AuthRepository _repo;
  RegisterUseCase(this._repo);
  @override
  Future<Either<Failure, UserLoginInfo>> call(RegisterParams params) =>
      _repo.register(params);
}
