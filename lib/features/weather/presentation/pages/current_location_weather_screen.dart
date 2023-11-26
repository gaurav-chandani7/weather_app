import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/dependencies_injection.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
import 'package:weather_app/features/weather/presentation/presentation.dart';

class CurrentLocationWeatherScreen extends StatelessWidget {
  const CurrentLocationWeatherScreen({
    Key? key,
    this.locationParams,
  }) : super(key: key);
  final LocationParams? locationParams;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locationParams != null
          ? (sl<CurrentWeatherCubit>()
            ..getWeatherFromDifferentLocation(locationParams!))
          : (sl<CurrentWeatherCubit>()..requestLocationAndGetWeather()),
      child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
        builder: (context, state) {
          if (state is CurrentWeatherSuccess) {
            var currentWeather = state.currentWeatherEntity!;
            return _getCurrentWeatherPageSuccessUI(currentWeather);
          }
          if (state is CurrentWeatherLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is CurrentWeatherFailure) {
            return CommonPageErrorWidget(
              message: state.message,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  SingleChildScrollView _getCurrentWeatherPageSuccessUI(
      CurrentWeatherEntity currentWeather) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CurrentWeatherTopSectionWidget(currentWeather: currentWeather),
          BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
              builder: (context, state) {
            var hourlyWidgetState = state.hourlyWidgetState;
            if (hourlyWidgetState is HourlyForecastSuccess) {
              return HourlyForecastWidget(
                hourlyForecast: hourlyWidgetState.hourlyForecastEntity,
              );
            }
            if (hourlyWidgetState is HourlyForecastLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          }),
          BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
              builder: (context, state) {
            var dailyWidgetState = state.dailyWidgetState;
            if (dailyWidgetState is DailyForecastSuccess) {
              return DailyForecastWidget(
                  dailyForecast: dailyWidgetState.dailyForecastEntity);
            }
            return const SizedBox();
          })
        ],
      ),
    );
  }
}
