import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:kptube_mobile/features/registration/screens/registration_screen/registration_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 60, 16, 16),
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Text('Авторизация', style: TextStyle(fontSize: 30)),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Имя:',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: _nameController,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Пароль:',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                  ),
                  SizedBox(height: 300),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 90, 90, 90),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 65,
                          child: Center(
                            child: state is AuthLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('Войти'),
                          ),
                        ),
                        onTap: state is AuthLoading
                            ? null
                            : () {
                                context.read<AuthBloc>().add(
                                  AuthUserEvent(
                                    _nameController.text,
                                    _passwordController.text,
                                  ),
                                );
                              },
                      );
                    },
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('нет аккаунта?', style: TextStyle(fontSize: 15)),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Material(
                                  type: MaterialType.transparency,
                                  child: Theme(
                                    data: theme,
                                    child: const RegistrationScreen(),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Создать аккаунт',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
