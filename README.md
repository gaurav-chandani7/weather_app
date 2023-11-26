# Weather App

This app shows current weather, hourly forecasts, daily forecasts for user's location as well as mult regions locations.

## Features
- Log in/Sign up functionality with Firebase Auth.
- Uses Current location to give updates like Current Weather, Hourly Forecasts, Daily Forecasts.
- Multi Region Weather updates of major cities of world.
- Shimmer as Loader to improve UX of app.
- Clean Architecture with BLoC as state management.

## Setup
- Place env file under assets/ directory to get app working.
- Env file contains API Key of OpenWeatherMap data source and it is not included in this repository.
- Open Project in VS Code or similar IDE, then run command - **_flutter pub get_** to install dependencies.
- Run the app directly with the Run button of IDE or use this command **_flutter run_**


## Generate app bundle
- run **_flutter build appbundle_** command to generate appbundle file.
- run **_flutter build apk_** command to generate apk file(s).