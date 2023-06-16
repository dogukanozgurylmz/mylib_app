import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mylib_app/model/bookcase_model.dart';
import 'package:mylib_app/repository/bookcase_repository.dart';
import 'package:mylib_app/repository/local_repository/auth_local_repository.dart';

part 'add_bookcase_state.dart';

class AddBookcaseCubit extends Cubit<AddBookcaseState> {
  AddBookcaseCubit({
    required AuthLocalRepository authLocalRepository,
    required BookcaseRepository bookcaseRepository,
  })  : _authLocalRepository = authLocalRepository,
        _bookcaseRepository = bookcaseRepository,
        super(const AddBookcaseState(
          status: AddBookcaseStatus.INIT,
        ));

  final AuthLocalRepository _authLocalRepository;
  final BookcaseRepository _bookcaseRepository;

  final TextEditingController titleController = TextEditingController();

  Future<void> submitForm() async {
    await createBookcase();
  }

  Future<void> createBookcase() async {
    var userModel = await _authLocalRepository.currentUser();
    BookcaseModel bookcaseModel = BookcaseModel(
      id: '',
      title: titleController.text.trim(),
      bookIds: [],
      userId: userModel.id,
      createdAt: DateTime.now(),
    );
    await _bookcaseRepository.createBookcase(bookcaseModel);
  }
}
