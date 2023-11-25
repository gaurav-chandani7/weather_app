import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/dependencies_injection.dart';
import 'package:weather_app/features/auth/presentation/cubit/login/auth_cubit.dart';
import 'package:weather_app/features/weather/presentation/pages/current_location_weather_screen.dart';
import 'package:weather_app/features/weather/presentation/pages/multi_region_screen.dart';
import 'package:weather_app/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _pages = const [
    CurrentLocationWeatherScreen(),
    MultiRegionScreen()
  ];

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Parent(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(child: Text("Weather app")),
              ElevatedButton(
                  onPressed: () {
                    context.dismiss();
                    setState(() {
                      _activePage = 0;
                    });
                  },
                  child: const Text("My Location")),
              ElevatedButton(
                  onPressed: () {
                    context.dismiss();
                    setState(() {
                      _activePage = 1;
                    });
                  },
                  child: const Text("Multi Region Forecast")),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      child: const Text('Logout'),
                      onPressed: () {
                        sl<AuthCubit>().logout();
                        context.pushReplacementNamed(Routes.login.path);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        child: _pages[_activePage]);
  }
}
