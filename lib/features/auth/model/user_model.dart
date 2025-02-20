class UserModel {
  final String displayName;
  final String username;
  final String email;
  final String profilePicture;
  final List<String> subscriptions;
  final int videos;
  final String userId;
  final String description;
  final String type;

  UserModel(
      {required this.displayName,
      required this.username,
      required this.email,
      required this.profilePicture,
      required this.subscriptions,
      required this.videos,
      required this.userId,
      required this.description,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'subscriptions': subscriptions,
      'videos': videos,
      'userId': userId,
      'description': description,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      profilePicture: map['profilePicture'] as String,
      subscriptions: List<String>.from(map['subscriptions']) ?? [],
      videos: map['videos'] as int,
      userId: map['userId'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
    );
  }
}
