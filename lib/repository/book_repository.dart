import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mylib_app/model/book_model.dart';

class BookRepository {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection('books');

  Future<String> createBook(BookModel model) async {
    String id = _ref.doc().id;
    model.id = id;
    await _ref.doc(id).set(model.toJson());
    return id;
  }

  Future<List<BookModel>> getBooks() async {
    final List<BookModel> list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _ref.orderBy('created_at', descending: true).get();
    querySnapshot.docs
        .map((e) => list.add(BookModel.fromJson(e.data())))
        .toList();
    return list;
  }

  Future<List<BookModel>> getBooksByIds(List<String> ids) async {
    final List<BookModel> list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _ref
        .where('id', whereIn: ids)
        .orderBy('created_at', descending: true)
        .get();
    list.addAll(querySnapshot.docs.map((e) => BookModel.fromJson(e.data())));
    return list;
  }

  Future<BookModel> getBook(String id) async {
    var documentSnapshot = await _ref.doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    return BookModel.fromJson(data!);
  }

  Future<void> updateBook(BookModel model) async {
    await _ref.doc(model.id).update(model.toJson());
  }

  Future<void> deleteBook(String id) async {
    await _ref.doc(id).delete();
  }
}
