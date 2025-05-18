import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/constants/constants.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/video/bloc/video_bloc.dart';
import 'package:kptube_mobile/features/video/utils/url_fixer.dart';
import 'package:kptube_mobile/features/video/widgets/video_app_bar.dart';
import 'package:kptube_mobile/features/video/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@RoutePage()
class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  String? _currentVideoId;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer(String videoId) async {
    if (_currentVideoId == videoId &&
        _controller != null &&
        _controller!.value.isInitialized) {
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      await _controller?.dispose();
      _controller = null;

      final response = await http.get(
        Uri.parse('$getVideosUrl?Video_ID=$videoId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final video = data[0];
          final videoUrl = UrlFixer.fixUrl(video['video']);

          _currentVideoId = videoId;
          _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

          _controller!.addListener(() {
            if (_controller!.value.isInitialized && mounted) {
              setState(() {
                _isLoading = false;
              });
              _controller!.play();
              _controller!.setLooping(true);
            }
          });

          await _controller!.initialize();
        } else {
          throw Exception('Видео не найдено');
        }
      } else {
        throw Exception('Ошибка загрузки видео: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Widget _buildVideoPlayer() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return _buildLoadingIndicator();
    }

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: VideoPlayer(_controller!),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 3.0,
          ),
          const SizedBox(height: 16),
          Text(
            'Загрузка видео...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String videoId) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Неизвестная ошибка',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  _errorMessage = null;
                });
                _initializeVideoPlayer(videoId);
              },
              child: const Text(
                'Попробовать снова',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is MainVideoTap) {
          context.read<VideoBloc>().add(
            GetVideoEvent(Video_ID: state.Video_ID),
          );
        }

        return Scaffold(
          appBar: const VideoAppBar(),
          body: BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              if (state is VideoSuccess || state is VideoLoading) {
                if (state is VideoSuccess) {
                  if (_controller == null ||
                      _currentVideoId != state.Video_ID ||
                      !_controller!.value.isInitialized) {
                    _initializeVideoPlayer(state.Video_ID);
                    return _buildLoadingIndicator();
                  }

                  if (_errorMessage != null) {
                    return _buildErrorWidget(state.Video_ID);
                  }

                  return _buildVideoPlayer();
                }
                return _buildLoadingIndicator();
              }

              if (state is VideoFailed) {
                return Center(
                  child: Text(
                    'Ошибка: ${state.error}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}