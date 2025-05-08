import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 10,
          separatorBuilder: (_, __) => const Divider(height: 32),
          itemBuilder: (_, index) => const VideoCard(),
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.play_circle_filled,
            size: 50,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Название видео Название видео Название видео',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        Text(
          'Имя автора • 100 просмотров',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}