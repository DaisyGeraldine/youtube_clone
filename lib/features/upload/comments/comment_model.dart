class CommentModel {
  final String commentText;
  final String videoId;
  final String commentId;
  final String displayName;
  final String profielePicture;

  CommentModel({
    required this.commentText,
    required this.videoId,
    required this.commentId,
    required this.displayName,
    required this.profielePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      "commentText": commentText,
      "videoId": videoId,
      "commentId": commentId,
      "displayName": displayName,
      "profielePicture": profielePicture,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentText: json["commentText"],
      videoId: json["videoId"],
      commentId: json["commentId"],
      displayName: json["displayName"],
      profielePicture: json["profielePicture"],
    );
  }

}
