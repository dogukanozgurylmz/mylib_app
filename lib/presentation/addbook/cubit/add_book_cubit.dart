import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mylib_app/model/book_model.dart';
import 'package:mylib_app/model/summary_model.dart';
import 'package:mylib_app/repository/local_repository/auth_local_repository.dart';

import '../../../model/bookcase_model.dart';
import '../../../model/user_model.dart';
import '../../../repository/auth_repository.dart';
import '../../../repository/book_repository.dart';
import '../../../repository/bookcase_repository.dart';
import '../../../repository/user_repository.dart';

part 'add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit({
    required AuthRepository authRepository,
    required BookRepository bookRepository,
    required BookcaseRepository bookcaseRepository,
    required UserRepository userRepository,
    required AuthLocalRepository authLocalRepository,
  })  : _authRepository = authRepository,
        _bookRepository = bookRepository,
        _bookcaseRepository = bookcaseRepository,
        _userRepository = userRepository,
        _authLocalRepository = authLocalRepository,
        super(AddBookState(
          status: AddBookStatus.INIT,
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          bookcases: const [],
          selectedBookcase: "",
        )) {
    init();
  }

  final AuthRepository _authRepository;
  final BookRepository _bookRepository;
  final BookcaseRepository _bookcaseRepository;
  final UserRepository _userRepository;
  final AuthLocalRepository _authLocalRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pageCountController = TextEditingController();

  String _bookId = "";

  Future<void> init() async {
    emit(state.copyWith(status: AddBookStatus.LOADING));
    await getBookcasesByUserId();
    emit(state.copyWith(status: AddBookStatus.LOADED));
  }

  void onTapStartDate(DateTime selectedDate) {
    if (selectedDate != null) {
      emit(state.copyWith(startDate: selectedDate));
    } else {
      emit(state.copyWith(startDate: DateTime.now()));
    }
  }

  void onTapEndDate(DateTime selectedDate) {
    if (selectedDate != null) {
      emit(state.copyWith(endDate: selectedDate));
    } else {
      emit(state.copyWith(endDate: DateTime.now()));
    }
  }

  void selectBookcase(String value) {
    emit(state.copyWith(selectedBookcase: value));
  }

  Future<void> getBookcasesByUserId() async {
    UserModel userModel = await _authLocalRepository.currentUser();
    var list = await _bookcaseRepository.getBookcasesByUserId(userModel.id);
    emit(state.copyWith(bookcases: list));
  }

  Future<void> submitForm() async {
    await createBook();
    await updateBookcase(_bookId);
  }

  Future<void> createBook() async {
    BookModel bookModel = BookModel(
      id: '',
      bookName: titleController.text.trim(),
      author: authorController.text.trim(),
      page: int.parse(pageCountController.text),
      isReading: false,
      starterDate: state.startDate,
      endDate: state.endDate,
      createdAt: DateTime.now(),
    );
    _bookId = await _bookRepository.createBook(bookModel);
  }

  Future<void> updateBookcase(String bookId) async {
    BookcaseModel firstWhere = state.bookcases
        .firstWhere((element) => element.title == state.selectedBookcase);
    firstWhere.bookIds.add(bookId);
    await _bookcaseRepository.update(firstWhere);
  }
}
