import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:weather_app/features/features.dart';
import 'package:weather_app/features/weather/presentation/cubit/multi_region/multi_region_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<Location>(Location.instance);
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<LocationDataSource>(
      () => LocationDataSourceImpl(sl()));
  sl.registerLazySingleton<OpenWeatherMapDataSource>(
      () => OpenWeatherMapDataSourceImpl());
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory<WeatherRepository>(
      () => WeatherRepositoryImpl(sl(), sl()));
}

void _useCase() {
  sl.registerFactory(() => RegisterUseCase(sl()));
  sl.registerFactory(() => LoginUseCase(sl()));
  sl.registerFactory(() => LogoutUseCase(sl()));
  sl.registerFactory(() => CheckLoggedInAndGetDetailsUseCase(sl()));
  sl.registerFactory(() => GetMyLocationDataUseCase(sl()));
  sl.registerFactory(() => GetCurrentWeatherUseCase(sl()));
  sl.registerFactory(() => GetHourlyForecast(sl()));
  sl.registerFactory(() => GetDailyForecastUseCase(sl()));
}

void _cubit() {
  sl.registerLazySingleton(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => CurrentWeatherCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MultiRegionCubit(sl()));
}
