import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}