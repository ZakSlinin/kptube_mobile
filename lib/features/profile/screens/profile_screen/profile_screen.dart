import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/features/profile/widgets/video_grid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<VideoPreview>? _videos;
  bool _isLoading = false;
  String? _error;
  String? _currentUsername;

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

  Future<void> _loadVideos(String username) async {
    print('Loading videos for username: $username');
    if (username.isEmpty) {
      print('Username is empty, setting empty videos list');
      setState(() {
        _videos = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });
    print('Started loading videos');

    try {
      final videos = await context.read<ProfileBloc>().getVideos(username);
      print('Successfully loaded ${videos.length} videos');
      if (mounted) {
        setState(() {
          _videos = videos;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading videos: $e');
      if (mounted) {
        setState(() {
          _error = 'Failed to load videos: $e';
          _isLoading = false;
        });
      }
    }
  }

  void _onVideoTap(VideoPreview video) {
    // TODO: Implement video playback
    print('Video tapped: ${video.Video_ID}');
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
            if (_currentUsername != state.profile.name) {
              _currentUsername = state.profile.name;
              Future.microtask(() => _loadVideos(state.profile.name ?? ''));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
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
                    ),
                    const SizedBox(height: 15),
                    // Profile info
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
                              if (_isLoading)
                                const Center(child: CircularProgressIndicator())
                              else if (_error != null)
                                Center(
                                  child: Text(
                                    _error!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                )
                              else if (_videos != null)
                                VideoGrid(
                                  videos: _videos!,
                                  onVideoTap: _onVideoTap,
                                )
                              else
                                const Center(
                                  child: Text('No videos available'),
                                ),

                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read<ProfileBloc>().add(
                                          LeaveProfileEvent(),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            90,
                                            90,
                                            90,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        height: 65,
                                        child: const Center(
                                          child: Text(
                                            'Выйти',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
