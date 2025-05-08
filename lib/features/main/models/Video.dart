class Video {
  final String id;
  final String name;
  final String owner;
  final String category;
  final String description;
  final String previewLink;
  final String videoLink;
  final int views;
  final int stars;
  final DateTime createdDate;
  final bool isDescriptionOpen;
  final String authorPhotoLink;
  final int authorSubscribers;
  final bool isSubscribe;

  Video({
    required this.id,
    required this.name,
    required this.owner,
    required this.category,
    required this.description,
    required this.previewLink,
    required this.videoLink,
    required this.views,
    required this.stars,
    DateTime? createdDate,
    this.isDescriptionOpen = false,
    required this.authorPhotoLink,
    required this.authorSubscribers,
    this.isSubscribe = false,
  }) : createdDate = createdDate ?? DateTime.now();

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json['Video_ID'] as String? ?? '',
    name: json['name'] as String? ?? '',
    owner: json['owner'] as String? ?? '',
    category: json['category'] as String? ?? '',
    description: json['description'] as String? ?? '',
    previewLink: json['previewLink'] as String? ?? '',
    videoLink: json['videoLink'] as String? ?? '',
    views: json['views'] as int? ?? 0,
    stars: json['stars'] as int? ?? 0,
    createdDate: json['createdDate'] != null
        ? DateTime.tryParse(json['createdDate'].toString())
        : null,
    isDescriptionOpen: json['isDescriptionOpen'] as bool? ?? false,
    authorPhotoLink: json['authorPhotoLink'] as String? ?? '',
    authorSubscribers: json['authorSubscribers'] as int? ?? 0,
    isSubscribe: json['isSubscribe'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() {
    return {
      'Video_ID': id,
      'name': name,
      'owner': owner,
      'category': category,
      'description': description,
      'previewLink': previewLink,
      'videoLink': videoLink,
      'views': views,
      'stars': stars,
      'createdDate': createdDate.toIso8601String(),
      'isDescriptionOpen': isDescriptionOpen,
      'authorPhotoLink': authorPhotoLink,
      'authorSubscribers': authorSubscribers,
      'isSubscribe': isSubscribe,
    };
  }
}

class Comment {
  String? userComment;
  String userName;
  dynamic userLikes;
  dynamic usersSubscribes;

  Comment({
    this.userComment,
    required this.userName,
    this.userLikes,
    this.usersSubscribes,
  });
}
