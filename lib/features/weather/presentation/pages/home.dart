import 'package:flutter/material.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/weather/presentation/pages/current_location_weather_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(child: Text("Weather app")),
              ElevatedButton(
                  onPressed: () {}, child: const Text("My Location")),
            ],
          ),
        ),
        child: const CurrentLocationWeatherScreen());
  }
}
