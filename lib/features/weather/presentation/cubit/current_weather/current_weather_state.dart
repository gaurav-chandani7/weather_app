part of 'current_weather_cubit.dart';

@immutable
sealed class CurrentWeatherState {
  final CurrentWeatherEntity? currentWeatherEntity;
  final String? errorMessage;
  final HourlyForecastWidgetState? hourlyWidgetState;
  final DailyForecastWidgetState? dailyWidgetState;

  const CurrentWeatherState(
      {this.currentWeatherEntity,
      this.errorMessage,
      this.dailyWidgetState,
      this.hourlyWidgetState});
}

final class CurrentWeatherInitial extends CurrentWeatherState {}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherSuccess extends CurrentWeatherState {
  const CurrentWeatherSuccess(
      {required super.currentWeatherEntity,
      super.dailyWidgetState,
      super.hourlyWidgetState});

  CurrentWeatherSuccess copyWith(
      {CurrentWeatherEntity? currentWeatherEntity,
      DailyForecastWidgetState? dailyForecastWidgetState,
      HourlyForecastWidgetState? hourlyWidgetState}) {
    return CurrentWeatherSuccess(
        currentWeatherEntity: currentWeatherEntity ?? this.currentWeatherEntity,
        dailyWidgetState: dailyForecastWidgetState ?? dailyWidgetState,
        hourlyWidgetState: this.hourlyWidgetState);
  }
}

final class CurrentWeatherFailure extends CurrentWeatherState {
  final String? message;

  const CurrentWeatherFailure({this.message}) : super(errorMessage: message);
}

//Hourly Forecast Widget states
abstract final class HourlyForecastWidgetState {}

final class HourlyForecastLoading extends HourlyForecastWidgetState {}

final class HourlyForecastSuccess extends HourlyForecastWidgetState {
  final HourlyForecastEntity hourlyForecastEntity;

  HourlyForecastSuccess({required this.hourlyForecastEntity});
}

final class HourlyForecastFailure extends HourlyForecastWidgetState {
  final String? message;

  HourlyForecastFailure({this.message});
}

//Daily Forecast Widget states

abstract class DailyForecastWidgetState {}

final class DailyForecastLoading extends DailyForecastWidgetState {
  DailyForecastLoading();
}

final class DailyForecastSuccess extends DailyForecastWidgetState {
  final DailyForecastEntity dailyForecastEntity;
  DailyForecastSuccess({required this.dailyForecastEntity});
}

final class DailyForecastFailure extends DailyForecastWidgetState {
  final String? message;
  DailyForecastFailure({this.message});
}
