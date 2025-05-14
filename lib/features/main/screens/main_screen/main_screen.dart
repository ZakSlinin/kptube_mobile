import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/profile/widgets/video_grid.dart';

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
    // TODO: Implement video playback
    print('Video tapped: ${video.Video_ID}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is MainLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Expanded(
              child: state is MainSuccess
                  ? VideoGrid(videos: state.videos, onVideoTap: _onVideoTap)
                  : const Center(child: Text('Нет доступных видео')),
            ),
          ],
        );
      },
    );
  }
}
