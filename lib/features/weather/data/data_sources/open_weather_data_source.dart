import 'dart:developer';

import 'package:dartz/dartz.dart';
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
        "http://pro.openweathermap.org/data/2.5/weather?lat=${locationParams.lat}&lon=${locationParams.lon}&units=metric&APPID=a07648b17e65f5114b7536b117dc11eb";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(CurrentWeatherModel.fromJson(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    return const Left(OtherFailure());
  }

  @override
  Future<Either<Failure, HourlyForecastModel>> getHourlyForecast(
      LocationParams locationParams) async {
    String url =
        "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=${locationParams.lat}&lon=${locationParams.lon}&units=metric&cnt=24&APPID=a07648b17e65f5114b7536b117dc11eb";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(HourlyForecastModel.fromJson(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    return const Left(OtherFailure());
  }

  @override
  Future<Either<Failure, DailyForecastModel>> getDailyForecast(
      LocationParams locationParams) async {
    String url =
        "http://pro.openweathermap.org/data/2.5/forecast/daily?lat=${locationParams.lat}&lon=${locationParams.lon}&units=metric&cnt=7&APPID=a07648b17e65f5114b7536b117dc11eb";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return Right(DailyForecastModel.fromJson(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    return const Left(OtherFailure());
  }
}
