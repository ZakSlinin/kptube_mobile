import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/core/routing/app_router.dart';
import 'package:kptube_mobile/core/widgets/video_grid_item.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/video/bloc/video_bloc.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  final StreamController<String> _searchStreamController =
      StreamController<String>.broadcast();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(GetMainEvent());

    _searchStreamController.stream.listen((query) {
      context.read<MainBloc>().add(SearchVideosEvent(query: query));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchStreamController.close();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchStreamController.add(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if (state is MainVideoTap) {
            BlocProvider.of<VideoBloc>(
              context,
            ).add(GetVideoEvent(Video_ID: state.Video_ID));
          }
        },
        builder: (context, state) {
          if (state is MainLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MainNavigateToHome) {
            context.read<MainBloc>().add(GetMainEvent());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MainSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<MainBloc>().add(GetMainEvent());
              },
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(20),
                        child: Center(
                          child: Container(
                            width: 350,
                            height: 40,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 3, 3, 3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                SvgPicture.asset(
                                  'assets/svg/Search.svg',
                                  fit: BoxFit.contain,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      hintText: 'Введите запрос',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: _onSearchChanged,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final video = state.videos[index];
                          return VideoGridItem(
                            key: ValueKey('video_${video.Video_ID}'),
                            video: video,
                            onTap: () {
                              context.read<MainBloc>().add(
                                VideoTap(Video_ID: video.Video_ID!),
                              );
                            },
                          );
                        }, childCount: state.videos.length),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text(
              'Хм, видео не обнаружено, попробуйте перезайти на главную страницу :)',
            ),
          );
        },
      ),
    );
  }
}
