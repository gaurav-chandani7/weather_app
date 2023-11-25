part of 'current_weather_cubit.dart';

@immutable
sealed class CurrentWeatherState {
  final CurrentWeatherEntity? currentWeatherEntity;
  final HourlyForecastEntity? hourlyForecastEntity;

  const CurrentWeatherState(
      {this.currentWeatherEntity, this.hourlyForecastEntity});
}

final class CurrentWeatherInitial extends CurrentWeatherState {}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherSuccess extends CurrentWeatherState {
  const CurrentWeatherSuccess(
      {required super.currentWeatherEntity, super.hourlyForecastEntity});
}

final class CurrentWeatherFailure extends CurrentWeatherState {
  final String? message;

  const CurrentWeatherFailure(this.message);
}

final class HourlyForecastLoading extends CurrentWeatherSuccess {
  const HourlyForecastLoading({required super.currentWeatherEntity});
}

final class HourlyForecastSuccess extends CurrentWeatherSuccess {
  const HourlyForecastSuccess(
      {required super.currentWeatherEntity,
      required super.hourlyForecastEntity});
}

final class HourlyForecastFailure extends CurrentWeatherSuccess {
  const HourlyForecastFailure({required super.currentWeatherEntity});
}
