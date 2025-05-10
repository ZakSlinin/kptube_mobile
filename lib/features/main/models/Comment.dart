class Comment {
  final String? userComment;
  final String userName;
  final int userLikes;
  final int usersSubscribes;

  Comment({
    this.userComment,
    required this.userName,
    this.userLikes = 0,
    this.usersSubscribes = 0,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userComment: json['userComment']?.toString(),
      userName: json['userName']?.toString() ?? '',
      userLikes: json['userLikes'] ?? 0,
      usersSubscribes: json['usersSubscribes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userComment': userComment,
      'userName': userName,
      'userLikes': userLikes,
      'usersSubscribes': usersSubscribes,
    };
  }
}
