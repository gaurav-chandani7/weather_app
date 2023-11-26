import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/domain/usecases/usecases.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit(this._getCurrentWeatherUseCase, this._getMyLocationData,
      this._getHourlyForecastUseCase, this._getDailyForecastUseCase)
      : super(CurrentWeatherInitial());

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final GetMyLocationDataUseCase _getMyLocationData;
  final GetHourlyForecast _getHourlyForecastUseCase;
  final GetDailyForecastUseCase _getDailyForecastUseCase;
  LocationParams? locationParamsData;

  requestLocationAndGetWeather() async {
    var locationData = await _getMyLocationData(null);
    locationData.fold((failure) {
      _requestLocationFailure(failure);
    }, (locationData) async {
      locationParamsData = LocationParams(
          lat: locationData.latitude, lon: locationData.longitude);
      emit(CurrentWeatherLoading());
      _getWeather(locationParamsData!);
    });
  }

  getWeatherFromDifferentLocation(LocationParams locationData) {
    locationParamsData = locationData;
    emit(CurrentWeatherLoading());
    _getWeather(locationData);
  }

  _getWeather(LocationParams locationData) async {
    var res = await _getCurrentWeatherUseCase(locationData);
    res.fold(
        (apiFailure) => emit(
            CurrentWeatherFailure(apiFailure.message ?? 'Unable to get data')),
        (weatherData) {
      emit(CurrentWeatherSuccess(currentWeatherEntity: weatherData));
      _getHourlyForecast();
      _getDailyForecast();
      //Getting both forecasts simultaneously
    });
  }

  _requestLocationFailure(failure) {
    if (failure is PermissionFailure) {
      emit(const CurrentWeatherFailure(
          'Permission Denied! \nUnable to get weather for your location. However you can always visit Multi region weather.'));
    } else if (failure is OtherFailure) {
      emit(CurrentWeatherFailure(failure.message));
    } else {
      emit(const CurrentWeatherFailure('Something went wrong'));
    }
  }

  _getHourlyForecast() async {
    if (locationParamsData != null) {
      emit(CurrentWeatherSuccess(
          currentWeatherEntity: state.currentWeatherEntity,
          dailyWidgetState: state.dailyWidgetState,
          hourlyWidgetState: HourlyForecastLoading()));
      var res = await _getHourlyForecastUseCase(locationParamsData!);
      res.fold(
          (apiFailure) => emit(CurrentWeatherSuccess(
              currentWeatherEntity: state.currentWeatherEntity,
              dailyWidgetState: state.dailyWidgetState,
              hourlyWidgetState: HourlyForecastFailure())),
          (hourlyForecast) => emit(CurrentWeatherSuccess(
              currentWeatherEntity: state.currentWeatherEntity,
              dailyWidgetState: state.dailyWidgetState,
              hourlyWidgetState: HourlyForecastSuccess(
                  hourlyForecastEntity: hourlyForecast))));
    }
  }

  _getDailyForecast() async {
    if (locationParamsData != null) {
      emit(CurrentWeatherSuccess(
          currentWeatherEntity: state.currentWeatherEntity,
          hourlyWidgetState: state.hourlyWidgetState,
          dailyWidgetState: DailyForecastLoading()));
      var res = await _getDailyForecastUseCase(locationParamsData!);
      res.fold(
          (failure) => emit(CurrentWeatherSuccess(
              currentWeatherEntity: state.currentWeatherEntity,
              hourlyWidgetState: state.hourlyWidgetState,
              dailyWidgetState:
                  DailyForecastFailure(message: failure.toString()))),
          (dailyForecast) => emit(CurrentWeatherSuccess(
              currentWeatherEntity: state.currentWeatherEntity,
              hourlyWidgetState: state.hourlyWidgetState,
              dailyWidgetState:
                  DailyForecastSuccess(dailyForecastEntity: dailyForecast))));
    }
  }
}
