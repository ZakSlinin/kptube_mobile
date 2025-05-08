import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileGetSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // user Header image
                    Image.network(
                      state.profile.header,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),

                    // Profile info row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(state.profile.avatar),
                          onBackgroundImageError: (exception, stackTrace) {
                            print('Error loading avatar image: $exception');
                            print('Stack trace: $stackTrace');
                          },
                          child: state.profile.avatar.isEmpty
                              ? SvgPicture.asset('assets/svg/Add_avatar.svg')
                              : null,
                        ),
                        const SizedBox(width: 15),

                        // Profile info column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.profile.name ?? 'Без имени',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Подписчиков: ${state.profile.subscribers}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Tabs
                    Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          tabs: const [
                            Tab(text: 'Видео'),
                            Tab(text: 'Настройки'),
                          ],
                        ),
                        SizedBox(
                          height: 300,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Container(child: const Text('Контент видео')),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BlocBuilder<ProfileBloc, ProfileState>(
                                      builder: (context, state) {
                                        return InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                255,
                                                90,
                                                90,
                                                90,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: 65,
                                            child: Center(child: Text('Выйти')),
                                          ),
                                          onTap: () {
                                            context.read<ProfileBloc>().add(
                                              LeaveProfileEvent(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    if (state.profile.videos.isNotEmpty) ...[
                      const Text(
                        'Мои видео',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            );
          }

          if (state is ProfileFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ошибка загрузки профиля'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileBloc>().add(GetProfileEvent());
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
