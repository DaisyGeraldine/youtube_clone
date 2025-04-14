import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';

final userDataServiceProvider = Provider((ref) => UserDataService(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class UserDataService {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firestore;
  UserDataService({
    required this.firebaseAuth,
    required this.firestore,
  });

  addUserDataToFirestore({
    required String displayName,
    required String username,
    required String email,
    required String photoURL,
    required String description,
  }) async {
    UserModel user = UserModel(
      displayName: displayName,
      username: username,
      email: email,
      profilePicture: photoURL,
      userId: firebaseAuth.currentUser!.uid,
      subscriptions: [],
      videos: 0,
      description: description,
      type: 'user',
    );

    await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.toMap());

    // try {
    //   final User? user = firebaseAuth.currentUser;
    //   await firestore.collection('users').doc(user!.uid).set({
    //     'uid': user.uid,
    //     'email': user.email,
    //     'photoURL': user.photoURL,
    //     'displayName': user.displayName,
    //     'lastSignInTime': user.metadata.lastSignInTime,
    //     'creationTime': user.metadata.creationTime,
    //   });
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<UserModel> fetchCurrentUserData() async {
    final currentUserMap = await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }

  Future<UserModel> fetchAnyUserData(userId) async {
    final currentUserMap = await firestore
        .collection("users")
        .doc(userId)
        .get();

    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }

  // Future<void> saveUserData(User user) async {
  //   try {
  //     await firestore.collection('users').doc(user.uid).set({
  //       'uid': user.uid,
  //       'email': user.email,
  //       'photoURL': user.photoURL,
  //       'displayName': user.displayName,
  //       'lastSignInTime': user.metadata.lastSignInTime,
  //       'creationTime': user.metadata.creationTime,
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
