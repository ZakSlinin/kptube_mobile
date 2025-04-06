import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final int? id;
  final int? Video_ID;
  final String? description;
  final List? likes;
  final int? views;
  final String? video;
  final String? preview;
  final String? category;
  final String? owner;
  final bool? isGlobal;
  final int? average_like;
  final String? name;

  const VideoEntity({
    this.id,
    this.Video_ID,
    this.description,
    this.likes,
    this.views,
    this.video,
    this.preview,
    this.category,
    this.owner,
    this.isGlobal,
    this.average_like,
    this.name,
  });

  @override
  List<Object?> get props {
    return [
      id,
      Video_ID,
      description,
      likes,
      views,
      video,
      preview,
      category,
      owner,
      isGlobal,
      average_like,
      name,
    ];
  }
}
