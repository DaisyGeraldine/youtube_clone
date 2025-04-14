import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String videoPath;
  final String thumbnailPath;
  final String title;
  final DateTime datePublished;
  final int videoViews;
  final String videoId;
  final String userId;
  final List likes;
  final String type;

  VideoModel({
    required this.videoPath,
    required this.thumbnailPath,
    required this.title,
    required this.datePublished,
    required this.videoViews,
    required this.videoId,
    required this.userId,
    required this.likes,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'videoPath': videoPath,
      'thumbnailPath': thumbnailPath,
      'title': title,
      'datePublished': datePublished,
      'videoViews': videoViews,
      'videoId': videoId,
      'userId': userId,
      'likes': likes,
      'type': type,
    };
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoPath: json['videoPath'],
      thumbnailPath: json['thumbnailPath'],
      title: json['title'],
      datePublished: json['datePublished'] is Timestamp
          ? (json['datePublished'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(json['datePublished'] as int),
      videoViews: json['videoViews'],
      videoId: json['videoId'],
      userId: json['userId'],
      likes: List.from(json['likes']),
      type: json['type'],
    );
  }
}
