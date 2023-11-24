import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';
import 'package:weather_app/features/auth/presentation/cubit/cubit.dart';
import 'package:weather_app/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Parent(
      child: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (_, state) {
            if (state is Loading) {
              context.showLoading();
            }
            if (state is Success) {
              context.dismiss();
              context.pushReplacementNamed(Routes.home.path);
            }
            if (state is LoginFailure) {
              context.dismiss();
              state.message.toToastError(context);
            }
          },
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Expanded(
                    flex: 15,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          "Login here",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 45,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: emailFieldValidator,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value != null && value.isNotEmpty
                                  ? null
                                  : 'Password Required',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().login(LoginParams(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              }
                            },
                            child: const Text("Login"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not Registered?"),
                            TextButton(
                                onPressed: () => context
                                    .pushReplacementNamed(Routes.register.path),
                                child: const Text("Register Here")),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
