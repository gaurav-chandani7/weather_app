import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/dependencies_injection.dart';
import 'package:weather_app/features/auth/presentation/presentation.dart';
import 'package:weather_app/features/weather/presentation/pages/current_location_weather_screen.dart';
import 'package:weather_app/features/weather/presentation/pages/home.dart';
import 'package:weather_app/features/weather/presentation/pages/multi_region_screen.dart';
import 'package:weather_app/utils/utils.dart';

enum Routes {
  root('/'),

  home('/home'),
  currentWeather('/home/currentWeather'),
  multiRegion('/home/multiRegion'),

  login("/auth/login"),
  register("/auth/register");

  const Routes(this.path);
  final String path;
}

Map<String, WidgetBuilder> routes = {
  Routes.root.path: (context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Success) {
            context.pushReplacementNamed(Routes.home.path);
          } else if (state is AuthInitial) {
            context.pushReplacementNamed(Routes.login.path);
          }
        },
        child: const SizedBox(),
      ),
  Routes.login.path: (context) => const LoginScreen(),
  Routes.register.path: (context) => BlocProvider(
      create: (context) => sl<RegisterCubit>(), child: const RegisterScreen()),
  Routes.home.path: (context) => const Home(),
  Routes.multiRegion.path: (context) => const MultiRegionScreen(),
  Routes.currentWeather.path: (context) => const CurrentLocationWeatherScreen()
};
