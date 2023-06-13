import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class UserRepository {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel model) async {
    String id = _ref.doc().id;
    model.id = id;
    await _ref.doc(id).set(model.toJson());
  }

  Future<UserModel> getUserById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await _ref.doc(id).get();
    if (docSnapshot.exists) {
      return UserModel.fromJson(docSnapshot.data()!);
    } else {
      throw Exception('User not found');
    }
  }

  Future<UserModel> getUserByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _ref.where('email', isEqualTo: email).get();
      return UserModel.fromJson(querySnapshot.docs.first.data());
    } catch (e) {
      return UserModel(
        id: '',
        fullName: '',
        photoUrl: '',
        email: '',
        createdAt: DateTime.now(),
      );
    }
  }

  Future<void> update(UserModel model) async {
    await _ref.doc(model.id).update(model.toJson());
  }

  Future<void> delete(String id) async {
    await _ref.doc(id).delete();
  }
}
