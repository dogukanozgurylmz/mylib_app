import 'package:hive/hive.dart';

import '../../model/user_model.dart';

class AuthLocalRepository {
  Future<void> create(UserModel model) async {
    var box = await Hive.openBox<UserModel>('users');
    box.add(model);
  }

  Future<void> clear() async {
    var box = await Hive.openBox<UserModel>('users');
    box.clear();
  }

  Future<UserModel> currentUser() async {
    var box = await Hive.openBox<UserModel>('users');
    return box.values.first;
  }
}
