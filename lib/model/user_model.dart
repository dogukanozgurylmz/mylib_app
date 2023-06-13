import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  final String fullName;
  final String photoUrl;
  final String email;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.photoUrl,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as String,
      fullName: json['fullname'] as String,
      photoUrl: json['photoUrl'] as String,
      email: json['email'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullName,
      'photoUrl': photoUrl,
      'email': email,
      'created_at': createdAt,
    };
  }
}
