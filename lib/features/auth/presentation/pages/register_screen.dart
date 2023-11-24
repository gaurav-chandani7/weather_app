import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/widgets/widgets.dart';
import 'package:weather_app/features/auth/domain/entities/entities.dart';
import 'package:weather_app/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:weather_app/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Parent(
      child: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              context.showLoading();
            } else if (state is RegisterSuccess) {
              //Redirect to Login page after succesful registeration
              context.dismiss();
              context.pushReplacementNamed(Routes.login.path);
            } else if (state is RegisterFailure) {
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
                        "Sign up",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            // TextFormField(
                            //   controller: _firstNameController,
                            //   decoration: const InputDecoration(
                            //     hintText: 'First name*',
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   keyboardType: TextInputType.name,
                            //   textCapitalization: TextCapitalization.words,
                            //   autofillHints: const [AutofillHints.givenName],
                            //   validator: (val) =>
                            //       requiredValidator(val, "First name"),
                            // ),
                            // const SizedBox(height: 20),
                            // TextFormField(
                            //   controller: _lastNameController,
                            //   decoration: const InputDecoration(
                            //     hintText: 'Last name*',
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   keyboardType: TextInputType.name,
                            //   textCapitalization: TextCapitalization.words,
                            //   autofillHints: const [AutofillHints.familyName],
                            //   validator: (val) =>
                            //       requiredValidator(val, "Last name"),
                            // ),
                            // const SizedBox(height: 20),
                            // TextFormField(
                            //   controller: _usernameController,
                            //   decoration: const InputDecoration(
                            //     hintText: 'Username',
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   keyboardType: TextInputType.name,
                            //   autofillHints: const [AutofillHints.username],
                            // ),
                            // const SizedBox(height: 20),
                            // TextFormField(
                            //   controller: _bioController,
                            //   decoration: const InputDecoration(
                            //     hintText: 'Bio',
                            //     border: OutlineInputBorder(),
                            //   ),
                            //   keyboardType: TextInputType.text,
                            //   textCapitalization: TextCapitalization.sentences,
                            //   autofillHints: const [AutofillHints.jobTitle],
                            // ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email*',
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
                                hintText: 'Password*',
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
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context
                                        .read<RegisterCubit>()
                                        .register(RegisterParams(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ));
                                  }
                                },
                                child: const Text("Sign Up"),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already Registered?"),
                                TextButton(
                                    onPressed: () =>
                                        context.pushReplacementNamed(
                                            Routes.login.path),
                                    child: const Text("Login Here")),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
