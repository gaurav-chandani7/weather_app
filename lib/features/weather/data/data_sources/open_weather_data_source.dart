import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/constants/url_constants.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/features/weather/data/models/models.dart';
import 'package:weather_app/features/weather/domain/entities/location_params.dart';
import 'package:http/http.dart' as http;

abstract class OpenWeatherMapDataSource {
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather(
      LocationParams locationParams);
  Future<Either<Failure, HourlyForecastModel>> getHourlyForecast(
      LocationParams locationParams);
  Future<Either<Failure, DailyForecastModel>> getDailyForecast(
      LocationParams locationParams);
}

class OpenWeatherMapDataSourceImpl implements OpenWeatherMapDataSource {
  @override
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather(
      LocationParams locationParams) async {
    String url =
        "$baseApiUrl/weather?lat=${locationParams.lat}&lon=${locationParams.lon}&units=$unitsParamApi&APPID=$appId";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(CurrentWeatherModel.fromJson(response.body));
      }
      return Left(ServerFailure(
          message: 'Server error: status code- ${response.statusCode}'));
    } catch (e) {
      if (e is SocketException) {
        return Left(NoInternetFailure());
      }
    }
    return const Left(OtherFailure());
  }

  @override
  Future<Either<Failure, HourlyForecastModel>> getHourlyForecast(
      LocationParams locationParams) async {
    String url =
        "$baseApiUrl/forecast/hourly?lat=${locationParams.lat}&lon=${locationParams.lon}&units=$unitsParamApi&cnt=$cntParamHourlyForecastApi&APPID=$appId";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(HourlyForecastModel.fromJson(response.body));
      }
      return Left(ServerFailure(
          message: 'Server error: status code- ${response.statusCode}'));
    } catch (e) {
      if (e is SocketException) {
        return Left(NoInternetFailure());
      }
    }
    return const Left(OtherFailure());
  }

  @override
  Future<Either<Failure, DailyForecastModel>> getDailyForecast(
      LocationParams locationParams) async {
    String url =
        "$baseApiUrl/forecast/daily?lat=${locationParams.lat}&lon=${locationParams.lon}&units=$unitsParamApi&cnt=$cntParamDailyForecastApi&APPID=$appId";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(DailyForecastModel.fromJson(response.body));
      }
      return Left(ServerFailure(
          message: 'Server error: status code- ${response.statusCode}'));
    } catch (e) {
      if (e is SocketException) {
        return Left(NoInternetFailure());
      }
    }
    return const Left(OtherFailure());
  }
}
