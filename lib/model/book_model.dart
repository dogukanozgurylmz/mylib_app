import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String id;
  final String bookName;
  final String author;
  final int page;
  final bool isReading;
  final DateTime starterDate;
  final DateTime endDate;
  final DateTime createdAt;

  BookModel({
    required this.id,
    required this.bookName,
    required this.author,
    required this.page,
    required this.isReading,
    required this.starterDate,
    required this.endDate,
    required this.createdAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["id"] as String,
      bookName: json['book_name'] as String,
      author: json['author'] as String,
      page: json['page'] as int,
      isReading: json['is_reading'] as bool,
      starterDate: (json['starter_date'] as Timestamp).toDate(),
      endDate: (json['end_date'] as Timestamp).toDate(),
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_name': bookName,
      'author': author,
      'page': page,
      'is_reading': isReading,
      'starter_date': starterDate.millisecondsSinceEpoch,
      'end_date': endDate.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }
}
