import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:kptube_mobile/core/routing/app_router.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AuthBloc _authBloc;
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>();
    _profileBloc = getIt<ProfileBloc>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _profileBloc),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (!mounted) return;
          if (state is AuthSuccess) {
            context.read<ProfileBloc>().add(GetProfileEvent());
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
              children: [
                const Center(
                  child: Text('Авторизация', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Имя:',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: _nameController,
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Пароль:',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: _passwordController,
                ),
                const SizedBox(height: 300),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 65,
                        child: Center(
                          child:
                              state is AuthLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text('Войти'),
                        ),
                      ),
                      onTap:
                          state is AuthLoading
                              ? null
                              : () {
                                _authBloc.add(
                                  AuthUserEvent(
                                    _nameController.text,
                                    _passwordController.text,
                                  ),
                                );
                              },
                    );
                  },
                ),
                const SizedBox(height: 5),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'нет аккаунта?',
                        style: TextStyle(fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          if (!mounted) return;
                          _profileBloc.add(
                            ProfileNavigateToRegistrationEvent(),
                          );
                        },
                        child: const Text(
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
    );
  }
}
