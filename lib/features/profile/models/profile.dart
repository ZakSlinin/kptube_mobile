import 'dart:io';

import 'package:kptube_mobile/core/models/video/video.dart';

class Profile {
  final String? name;
  final String avatar;
  final String header;
  final List<dynamic> history;
  final List<String> videoIds;
  final int subscribers;
  final String? User_ID;
  final bool isEmailVerified;
  final Map<String, dynamic> liked;
  final List<dynamic> subscribes;

  Profile({
    this.name,
    required this.avatar,
    required this.header,
    required this.history,
    required this.videoIds,
    required this.subscribers,
    this.User_ID,
    required this.isEmailVerified,
    required this.liked,
    required this.subscribes,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String?,
      avatar: fixUrl(json['avatar'] as String? ?? ''),
      header: fixUrl(json['header'] as String? ?? ''),
      history: json['history'] as List<dynamic>? ?? [],
      videoIds: (json['videos'] as String? ?? '')
          .split(',')
          .where((id) => id.isNotEmpty)
          .toList(),
      subscribers: json['subscribers'] as int? ?? 0,
      User_ID: json['User_ID']?.toString(),
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      liked: json['liked'] as Map<String, dynamic>? ?? {},
      subscribes: json['subscribes'] as List<dynamic>? ?? [],
    );
  }
}

String fixUrl(String url) {
  print('Original URL: $url');
  if (url.isEmpty) {
    print('Empty URL, returning empty string');
    return url;
  }

  if (url.startsWith('http://127.0.0.1:8000')) {
    final fixedUrl = url.replaceFirst(
      'http://127.0.0.1:8000',
      'https://kptube.kringeproduction.ru/files/',
    );
    print('Fixed localhost URL: $fixedUrl');
    return fixedUrl;
  }

  if (url.startsWith('http://localhost:8000')) {
    final fixedUrl = url.replaceFirst(
      'http://localhost:8000',
      'https://kptube.kringeproduction.ru/files/',
    );
    print('Fixed localhost URL: $fixedUrl');
    return fixedUrl;
  }

  print('URL already correct: $url');
  return url;
}
