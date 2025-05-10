class ProfileVideo {
  final int? id;
  final String? Video_ID;
  final int? views;
  final String? video;
  final String? preview;
  final String? owner;

  ProfileVideo({
    this.id,
    this.Video_ID,
    this.views,
    this.video,
    this.preview,
    this.owner,
  });

  factory ProfileVideo.fromJson(Map<String, dynamic> json) {
    return ProfileVideo(
      Video_ID: json['Video_ID'] as String?,
      views: json['views'] as int?,
      video: json['video'] as String?,
      preview: json['preview'] as String?,
      owner: json['owner'] as String?,
    );
  }
}
