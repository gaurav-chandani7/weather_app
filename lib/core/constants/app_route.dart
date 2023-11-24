import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/dependencies_injection.dart';
import 'package:weather_app/features/auth/presentation/cubit/cubit.dart';
import 'package:weather_app/features/auth/presentation/pages/pages.dart';
import 'package:weather_app/utils/utils.dart';

enum Routes {
  root('/'),

  home('/home'),

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
  Routes.login.path: (context) => LoginScreen(),
  Routes.register.path: (context) => BlocProvider(
      create: (context) => sl<RegisterCubit>(), child: RegisterScreen()),
  Routes.home.path: (context) => Parent(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                sl<AuthCubit>().logout();
                context.pushReplacementNamed(Routes.login.path);
              },
              child: Text("Logout")),
        ),
      )
};
