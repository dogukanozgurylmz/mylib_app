import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/bookcase_model.dart';

class BookcaseRepository {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection('bookcases');

  Future<void> createBookcase(BookcaseModel model) async {
    String id = _ref.doc().id;
    model.id = id;
    await _ref.doc(id).set(model.toJson());
  }

  Future<List<BookcaseModel>> getBookcasesByUserId(String userId) async {
    List<BookcaseModel> list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _ref
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
    querySnapshot.docs.map((doc) {
      list.add(BookcaseModel.fromJson(doc.data()));
    }).toList();
    return list;
  }

  Future<BookcaseModel> getBookcase(String id) async {
    var documentSnapshot = await _ref.doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    return BookcaseModel.fromJson(data!);
  }

  Future<void> update(BookcaseModel model) async {
    await _ref.doc(model.id).update(model.toJson());
  }

  Future<void> delete(String id) async {
    await _ref.doc(id).delete();
  }
}
