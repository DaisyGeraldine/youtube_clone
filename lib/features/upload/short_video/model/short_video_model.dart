class ShortVideoModel {
  final String caption;
  final String userId;
  final String shortVideo;
  final DateTime datePublished;
  ShortVideoModel ({
    required this.caption,
    required this.userId,
    required this.shortVideo,
    required this.datePublished,
  });
  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'userId': userId,
      'shortVideo': shortVideo,
      'datePublished': datePublished.millisecondsSinceEpoch,
    };
  }

  // factory ShortVideoModel.fromJson(Map<String, dynamic> json) {
  //   return ShortVideoModel(
  //     caption: json['caption'],
  //     userId: json['userId'],
  //     shortVideo: json['shortVideo'],
  //     datePublished: (json['datePublished'] as Timestamp).toDate(),
  //   );
  // }
}