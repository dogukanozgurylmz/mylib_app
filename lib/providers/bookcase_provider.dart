import 'package:flutter/material.dart';

import '../model/bookcase_model.dart';

class BookcaseProvider extends ChangeNotifier {
  BookcaseModel? _bookCase;

  BookcaseModel? get bookCase => _bookCase;

  set bookCase(BookcaseModel? value) {
    _bookCase = value;
    notifyListeners();
  }
}
