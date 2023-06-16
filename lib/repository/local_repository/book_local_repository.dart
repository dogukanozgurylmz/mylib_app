import 'package:hive/hive.dart';
import 'package:mylib_app/model/book_model.dart';

class BookLocalRepository {
  Future<void> create(List<BookModel> books) async {
    var box = await Hive.openBox<BookModel>('books');
    box.addAll(books);
  }

  Future<void> clear() async {
    var box = await Hive.openBox<BookModel>('books');
    box.clear();
  }

  Future<List<BookModel>> getBooks() async {
    var box = await Hive.openBox<BookModel>('books');
    return box.values.toList();
  }
}
