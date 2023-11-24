import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/error/error.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';
import 'package:weather_app/features/auth/domain/usecases/usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase, this._logoutUseCase,
      this._checkLoggedInAndGetDetailsUseCase)
      : super(AuthInitial()) {
    checkLoggedInSession();
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckLoggedInAndGetDetailsUseCase _checkLoggedInAndGetDetailsUseCase;

  Future<void> login(LoginParams loginParams) async {
    emit(Loading());
    final data = await _loginUseCase(loginParams);

    data.fold((l) {
      if (l is ServerFailure) {
        emit(LoginFailure(l.message ?? ""));
      }
    }, (r) => emit(Success(data: r)));
  }

  Future<void> logout() async {
    emit(Loading());
    final data = await _logoutUseCase(null);
    data.fold((l) {
      if (l is ServerFailure) {
        emit(LoginFailure(l.message ?? ""));
      }else{
        emit(const LoginFailure("Something went wrong."));
      }
    }, (r) => emit(AuthInitial()));
  }

  Future<void> checkLoggedInSession() async {
    emit(FetchingSession());
    final data = await _checkLoggedInAndGetDetailsUseCase(null);
    data.fold((l) => emit(AuthInitial()), (r) => emit(Success(data: r)));
  }
}
