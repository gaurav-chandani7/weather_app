import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/auth/auth.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
}

void _repositories() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
}

void _useCase() {
  sl.registerFactory(() => RegisterUseCase(sl()));
  sl.registerFactory(() => LoginUseCase(sl()));
  sl.registerFactory(() => LogoutUseCase(sl()));
  sl.registerFactory(() => CheckLoggedInAndGetDetailsUseCase(sl()));
}

void _cubit() {
  sl.registerLazySingleton(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => RegisterCubit(sl()));
}
