import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/features/auth/data/data_sources/data_sources.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';
import 'package:weather_app/features/auth/domain/repository/repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, UserLoginInfo>> login(LoginParams loginParams) async {
    //Auth service login
    final response = await authRemoteDataSource.login(loginParams);
    return response.fold((failure) {
      return Left(failure);
    }, (loginResponse) => Right(UserLoginInfo(email: loginParams.email ?? "")));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final response = await authRemoteDataSource.logout();
    return response.fold((failure) => Left(failure), (r) => const Right(null));
  }

  @override
  Future<Either<Failure, UserLoginInfo>> register(
      RegisterParams registerParams) async {
    //Adding user to authentication service
    final response = await authRemoteDataSource.register(registerParams);

    return response.fold((failure) => Left(failure), (registerResponse) {
      //User will login again from login page
      logout();
      return Right(UserLoginInfo(
        email: registerParams.email,
      ));
    });
  }

  @override
  Future<Either<Failure, UserLoginInfo>> checkLoggedInAndGetDetails() async {
    var userDetails = authRemoteDataSource.loggedInUser;
    if (userDetails == null) {
      return const Left(OtherFailure(message: "Not logged in"));
    }
    return Right(UserLoginInfo(email: userDetails.email ?? ""));
  }
}
