import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/auth/repository/user_data_service.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final UserModel userDataService =
      await ref.watch(userDataServiceProvider).fetchCurrentUserData();
  return userDataService;
});
