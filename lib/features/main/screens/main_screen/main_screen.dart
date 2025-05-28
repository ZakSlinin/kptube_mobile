import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(GetMainEvent());
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
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 3, 3, 3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                SvgPicture.asset(
                                  'assets/svg/Search.svg',
                                  fit: BoxFit.contain,
                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Введите запрос',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
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
                              print('${video.name} tapped');
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
          return Center(
            child: Text(
              'Хм, видео не обнаружено, попробуйте перезайти на главную страницу :)',
            ),
          );
        },
      ),
    );
  }
}
