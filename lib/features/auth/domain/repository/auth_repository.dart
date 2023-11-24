import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserLoginInfo>> login(LoginParams loginParams);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserLoginInfo>> register(
      RegisterParams registerParams);
  Future<Either<Failure, UserLoginInfo>> checkLoggedInAndGetDetails();
}
