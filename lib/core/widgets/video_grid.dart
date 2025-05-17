import 'package:flutter/material.dart';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/core/widgets/video_grid_item.dart';

class VideoGrid extends StatelessWidget {
  final List<VideoPreview> videos;
  final Function(VideoPreview) onVideoTap;

  const VideoGrid({Key? key, required this.videos, required this.onVideoTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const Center(child: Text('Видео еще не публиковались'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideoGridItem(video: video, onTap: () => onVideoTap(video));
      },
    );
  }
}
