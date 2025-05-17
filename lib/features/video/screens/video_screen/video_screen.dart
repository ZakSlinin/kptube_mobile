import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/video/bloc/video_bloc.dart';

@RoutePage()
class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is MainVideoTap) {
          print(
            'VideoScreen: Received MainVideoTap state with ID: ${state.Video_ID}',
          );
          context.read<VideoBloc>().add(
            GetVideoEvent(Video_ID: state.Video_ID),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: GestureDetector(
            key: const ValueKey('video_screen'),
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                // Swipe right
                context.read<MainBloc>().add(GetMainEvent());
              }
            },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      context.read<MainBloc>().add(GetMainEvent());
                    },
                    icon: Icon(
                      Icons.keyboard_return,
                      size: 46,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              body: BlocBuilder<VideoBloc, VideoState>(
                builder: (context, state) {
                  print('VideoScreen: Current VideoBloc state: $state');
                  if (state is VideoLoading) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            'Loading video...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is VideoSuccess) {
                    return Column(
                      children: [
                        Text(
                          'Playing video: ${state.Video_ID}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  }
                  if (state is VideoFailed) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
