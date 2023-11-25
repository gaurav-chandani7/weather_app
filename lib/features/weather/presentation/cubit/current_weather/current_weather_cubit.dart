import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_forecast.dart';
import 'package:weather_app/features/weather/domain/usecases/get_hourly_forecast.dart';
import 'package:weather_app/features/weather/domain/usecases/usecases.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit(this._getCurrentWeatherUseCase, this._getMyLocationData,
      this._getHourlyForecastUseCase)
      : super(CurrentWeatherInitial());

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final GetMyLocationDataUseCase _getMyLocationData;
  final GetHourlyForecast _getHourlyForecastUseCase;
  LocalLocationEntity? localLocationData;

  requestLocationAndGetWeather() async {
    var locationData = await _getMyLocationData(null);
    locationData.fold((failure) {
      _requestLocationFailure(failure);
    }, (locationData) async {
      localLocationData = locationData;
      emit(CurrentWeatherLoading());
      _getWeather(locationData);
    });
  }

  _getWeather(LocalLocationEntity locationData) async {
    var res = await _getCurrentWeatherUseCase(LocationParams(
        lat: locationData.latitude, lon: locationData.longitude));
    res.fold(
        (apiFailure) => emit(const CurrentWeatherFailure('Unable to get data')),
        (weatherData) {
      emit(CurrentWeatherSuccess(currentWeatherEntity: weatherData));
      _getHourlyForecast();
    });
  }

  _requestLocationFailure(failure) {
    if (failure is PermissionFailure) {
      emit(CurrentWeatherFailure(failure.message));
    } else if (failure is OtherFailure) {
      emit(CurrentWeatherFailure(failure.message));
    } else {
      emit(const CurrentWeatherFailure('Something went wrong'));
    }
  }

  _getHourlyForecast() async {
    if (localLocationData != null) {
      emit(HourlyForecastLoading(
          currentWeatherEntity: state.currentWeatherEntity));
      var res = await _getHourlyForecastUseCase(LocationParams(
          lat: localLocationData!.latitude, lon: localLocationData!.longitude));
      res.fold(
          (apiFailure) => emit(HourlyForecastFailure(
              currentWeatherEntity: state.currentWeatherEntity)),
          (hourlyForecast) => emit(HourlyForecastSuccess(
              currentWeatherEntity: state.currentWeatherEntity,
              hourlyForecastEntity: hourlyForecast)));
    }
  }
}
