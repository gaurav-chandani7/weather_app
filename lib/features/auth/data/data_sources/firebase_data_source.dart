import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, UserCredential>> login(LoginParams loginParams);

  Future<Either<Failure, UserCredential>> register(
      RegisterParams registerParams);

  Future<Either<Failure, void>> logout();

  User? get loggedInUser;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  User? get loggedInUser => FirebaseAuth.instance.currentUser;

  @override
  Future<Either<Failure, UserCredential>> login(LoginParams loginParams) async {
    try {
      var response = await _firebaseAuth.signInWithEmailAndPassword(
          email: loginParams.email ?? "", password: loginParams.password ?? "");
      return Right(response);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "INVALID_LOGIN_CREDENTIALS") {
          return const Left(
              ServerFailure(message: "Invalid Login Credentials"));
        }
        return Left(ServerFailure(message: e.message));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> register(
      RegisterParams params) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: params.email, password: params.password);
      return Right(response);
    } catch (e) {
      log(e.toString());
      if (e is FirebaseAuthException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
