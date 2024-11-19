class Comment {
  final String commentId;
  final String userId;
  final String userPhoto;
  final String username;
  final String comment;

  Comment({
    required this.commentId,
    required this.userId,
    required this.userPhoto,
    required this.username,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      userId: json['userId'],
      userPhoto: json['userPhoto'],
      username: json['username'],
      comment: json['comment'],
    );
  }
}
