import 'dart:io';

class Profile {
  final String? name;
  final String avatar;
  final String header;
  final List<dynamic> history;
  final List<Video> videos;
  final List<String>? subscribers;
  final String? User_ID;

  Profile({
    this.name,
    required this.avatar,
    required this.header,
    required this.history,
    required this.videos,
    this.subscribers,
    this.User_ID,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String?,
      avatar: json['avatar'] as String? ?? '',
      header: json['header'] as String? ?? '',
      history: json['history']! as List,
      videos: (json['videos'] as String? ?? '')
          .split(',')
          .where((id) => id.isNotEmpty)
          .map(
            (id) => Video(
              title: 'Video $id',
              description: null,
              thumbnail: '',
              videoUrl: '',
            ),
          )
          .toList(),
      subscribers: (json['subscribers'] as List<dynamic>?)
          ?.map((sub) => sub.toString())
          .toList(),
      User_ID: json['User_ID']?.toString(),
    );
  }
}

class Video {
  final String title;
  final String? description;
  final String thumbnail;
  final String videoUrl;

  Video({
    required this.title,
    this.description,
    required this.thumbnail,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String,
      videoUrl: json['video_url'] as String,
    );
  }
}
