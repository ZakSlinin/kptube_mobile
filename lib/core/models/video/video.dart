class VideoPreview {
  final int? id;
  final String? Video_ID;
  final String? name;
  final int? views;
  final String? video;
  final String? preview;
  final String? owner;

  VideoPreview({
    this.id,
    this.Video_ID,
    this.name,
    this.views,
    this.video,
    this.preview,
    this.owner,
  });

  factory VideoPreview.fromJson(Map<String, dynamic> json) {
    return VideoPreview(
      Video_ID: json['Video_ID'] as String?,
      name: json['name'] as String?,
      views: json['views'] as int?,
      video: json['video'] as String?,
      preview: fixUrl(json['preview']! as String? ?? ''),
      owner: json['owner'] as String?,
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
