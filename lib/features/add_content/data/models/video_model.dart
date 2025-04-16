import 'package:kptube_mobile/features/add_content/domain/entities/video.dart';

class VideoModel extends VideoEntity {
  const VideoModel({
    int? id,
    int? Video_ID,
    String? name,
    String? description,
    List? likes,
    int? views,
    String? video,
    String? preview,
    String? category,
    String? owner,
    bool? isGlobal,
    int? average_like,
  });

  factory VideoModel.fromJson(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] ?? '',
      Video_ID: map['Video_ID'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      likes: map['likes'] ?? '',
      views: map['views'] ?? '',
      video: map['video'] ?? '',
      preview: map['preview'] ?? '',
      category: map['category'] ?? '',
      owner: map['owner'] ?? '',
      isGlobal: map['isGlobal'] ?? '',
      average_like: map['average_like'] ?? '',
    );
  }
}
