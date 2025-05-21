import 'package:flutter/material.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/video/bloc/video_bloc.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  BetterPlayerController? _betterPlayerController;
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void dispose() {
    _betterPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(String videoUrl) async {
    try {
      print('Initializing video with URL: $videoUrl');

      final betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoUrl,
        liveStream: false,
        headers: const {'Access-Control-Allow-Origin': '*'},
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
          maxCacheSize: 10 * 1024 * 1024, // 10MB
          maxCacheFileSize: 2 * 1024 * 1024, // 2MB
        ),
      );

      final betterPlayerConfiguration = BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        looping: true,
        handleLifecycle: true,
        allowedScreenSleep: false,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enableSubtitles: false,
          enableAudioTracks: false,
          enablePip: false,
          enablePlayPause: true,
          enablePlaybackSpeed: true,
          enableFullscreen: true,
          enableSkips: false,
          enableOverflowMenu: true,
          loadingColor: Colors.white,
          iconsColor: Colors.white,
          controlBarColor: Colors.black54,
          controlBarHeight: 40,
          liveTextColor: Colors.red,
          overflowMenuIconsColor: Colors.white,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 42),
                const SizedBox(height: 16),
                Text(
                  'Error: $errorMessage',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );

      _betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration,
      );

      // Add event listener for debugging
      _betterPlayerController!.addEventsListener((event) {
        print('BetterPlayer event: ${event.betterPlayerEventType}');
        if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
          setState(() {
            _errorMessage = event.parameters?['error']?.toString();
          });
        }
      });

      await _betterPlayerController!.setupDataSource(betterPlayerDataSource);

      if (!mounted) return;

      setState(() {
        _isInitialized = true;
        _errorMessage = null;
      });
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _errorMessage = e.toString();
      });
    }
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
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

              if (_errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 42,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: $_errorMessage',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  if (!_isInitialized) const CircularProgressIndicator(),
                  if (_isInitialized && _betterPlayerController != null)
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: BetterPlayer(controller: _betterPlayerController!),
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
