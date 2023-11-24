import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';
import 'package:weather_app/features/auth/domain/repository/repository.dart';

class LoginUseCase implements UseCase<UserLoginInfo, LoginParams> {
  final AuthRepository _repo;

  LoginUseCase(this._repo);

  @override
  Future<Either<Failure, UserLoginInfo>> call(LoginParams params) =>
      _repo.login(params);
}
