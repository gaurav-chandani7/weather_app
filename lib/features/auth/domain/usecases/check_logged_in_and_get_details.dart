import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';
import 'package:weather_app/features/auth/domain/repository/repository.dart';


class CheckLoggedInAndGetDetailsUseCase extends UseCase<UserLoginInfo, void> {
  final AuthRepository _repo;

  CheckLoggedInAndGetDetailsUseCase(this._repo);
  @override
  Future<Either<Failure, UserLoginInfo>> call(void params) async =>
      _repo.checkLoggedInAndGetDetails();
}
