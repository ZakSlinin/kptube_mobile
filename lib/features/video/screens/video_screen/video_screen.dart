import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/video/bloc/video_bloc.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  bool _isInitialized = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  Future<void> _initializeVideo(String videoUrl) async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      await _videoPlayerController.initialize();

      if (!mounted) return;

      _videoPlayerController.setLooping(true);
      _videoPlayerController.setVolume(1.0);

      setState(() {
        _isInitialized = true;
      });

      _animationController.forward();
      await _videoPlayerController.play();
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _videoPlayerController.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (context.read<MainBloc>().state is MainVideoTap) {
            context.read<MainBloc>().add(NavigateToHomeEvent());
          } else if (context.read<ProfileBloc>().state
              is ProfileVideoTapState) {
            context.read<ProfileBloc>().add(ProfileNavigateBackEvent());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Video player screen',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VideoSuccess) {
              if (!_isInitialized) {
                _initializeVideo(state.videoUrl);
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (!_isInitialized) const CircularProgressIndicator(),
                  if (_isInitialized)
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    ),
                ],
              );
            }

            if (state is VideoFailed) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
