import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/core/routing/app_router.dart';
import 'package:kptube_mobile/core/widgets/video_grid_item.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';

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

  void _onVideoTap(VideoPreview video) {
    context.router.replace(VideoRoute());
    print('Video tapped: ${video.Video_ID}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MainSuccess) {
            return CustomScrollView(
              slivers: [
                const SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 60, 16, 16),
                  sliver: SliverToBoxAdapter(child: SizedBox(height: 12)),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final video = state.videos[index];
                      return VideoGridItem(
                        key: ValueKey('video_${video.Video_ID}'),
                        video: video,
                        onTap: () => _onVideoTap(video),
                      );
                    }, childCount: state.videos.length),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Нет доступных видео'));
        },
      ),
    );
  }
}
