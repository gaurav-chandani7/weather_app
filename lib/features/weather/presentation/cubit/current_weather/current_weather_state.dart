part of 'current_weather_cubit.dart';

@immutable
sealed class CurrentWeatherState {
  final CurrentWeatherEntity? currentWeatherEntity;

  const CurrentWeatherState({this.currentWeatherEntity});
}

final class CurrentWeatherInitial extends CurrentWeatherState {}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherSuccess extends CurrentWeatherState {
  const CurrentWeatherSuccess({required super.currentWeatherEntity});
}

final class CurrentWeatherFailure extends CurrentWeatherState {
  final String? message;

  const CurrentWeatherFailure(this.message);
}
