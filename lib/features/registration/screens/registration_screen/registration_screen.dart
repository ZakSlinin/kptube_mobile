import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kptube_mobile/core/routing/app_router.dart';
import 'package:kptube_mobile/core/services/image_picker/image_picker.dart';
import 'package:kptube_mobile/features/registration/bloc/registration_bloc.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File? _selectedImageAvatar;
  File? _selectedImageHeader;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('RegistrationScreen: initState');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleAvatarPick(ImageSource source) async {
    try {
      final File? image = await pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImageAvatar = image;
        });
      }
      Navigator.pop(context);
    } catch (e) {
      print('Error picking avatar: $e');
    }
  }

  Future<void> _handleHeaderPick(ImageSource source) async {
    try {
      final File? header = await pickImageHeader(source: source);
      if (header != null) {
        setState(() {
          _selectedImageHeader = header;
        });
      }
      Navigator.pop(context);
    } catch (e) {
      print('Error picking header: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider.value(
      value: context.read<RegistrationBloc>(),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          print('RegistrationScreen: Received state: $state');
          if (!mounted) return;

          if (state is RegistrationSuccess) {
            print('RegistrationScreen: Navigating to HomeRoute');
            context.read<ProfileBloc>().add(GetProfileEvent());
          } else if (state is RegistrationFailed) {
            print('RegistrationScreen: Showing error: ${state.error}');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Регистрация',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: InkWell(
                        onTap:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('Выберите источник, не выбирайте формат xml или .svg'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          _handleAvatarPick(ImageSource.camera);
                                        },
                                        child: const Text('Камера'),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () => _handleAvatarPick(
                                              ImageSource.gallery,
                                            ),
                                        child: const Text('Галерея'),
                                      ),
                                    ],
                                  ),
                            ),
                        child: Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(65),
                          ),
                          child:
                              _selectedImageAvatar != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(65),
                                    child: Image.file(
                                      _selectedImageAvatar!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : SvgPicture.asset(
                                    'assets/svg/Add_avatar.svg',
                                    height: 125,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: InkWell(
                        onTap:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('Выберите источник'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed:
                                            () => _handleHeaderPick(
                                              ImageSource.camera,
                                            ),
                                        child: const Text('Камера'),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () => _handleHeaderPick(
                                              ImageSource.gallery,
                                            ),
                                        child: const Text('Галерея'),
                                      ),
                                    ],
                                  ),
                            ),
                        child: Container(
                          height: 108,
                          width: 317,
                          child:
                              _selectedImageHeader != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _selectedImageHeader!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : SvgPicture.asset(
                                    'assets/svg/Add_header.svg',
                                    height: 125,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Имя:',
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email:',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      controller: _emailController,
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
                        final String User_ID =
                            (DateTime.now().millisecond).toString();

                        if (_nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, введите имя'),
                            ),
                          );
                          return;
                        }

                        if (_emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, введите email'),
                            ),
                          );
                          return;
                        }

                        if (_passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, введите пароль'),
                            ),
                          );
                          return;
                        }

                        if (_selectedImageAvatar == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, выберите аватар'),
                            ),
                          );
                          return;
                        }

                        if (_selectedImageHeader == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, выберите обложку'),
                            ),
                          );
                          return;
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(_emailController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Пожалуйста, введите корректный email',
                              ),
                            ),
                          );
                          return;
                        }

                        if (_passwordController.text.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Пароль должен содержать минимум 6 символов',
                              ),
                            ),
                          );
                          return;
                        }

                        context.read<RegistrationBloc>().add(
                          RegisterUserEvent(
                            _nameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _selectedImageAvatar!,
                            _selectedImageHeader!,
                            User_ID,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 65,
                        child: const Center(child: Text('Создать аккаунт')),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'есть аккаунт?',
                            style: TextStyle(fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              print('RegistrationScreen: Login button tapped');
                              if (!mounted) return;
                              context.read<ProfileBloc>().add(
                                ProfileNavigateToAuthEvent(),
                              );
                            },
                            child: const Text(
                              'Войти',
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
      ),
    );
  }
}
