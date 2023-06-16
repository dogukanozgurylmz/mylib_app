import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylib_app/model/book_model.dart';
import 'package:mylib_app/repository/auth_repository.dart';
import 'package:mylib_app/repository/local_repository/auth_local_repository.dart';
import 'package:mylib_app/repository/local_repository/book_local_repository.dart';

import '../../../model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthLocalRepository authLocalRepository,
    required AuthRepository authRepository,
    required BookLocalRepository bookLocalRepository,
  })  : _authLocalRepository = authLocalRepository,
        _authRepository = authRepository,
        _bookLocalRepository = bookLocalRepository,
        super(ProfileState(
          status: ProfileStatus.INIT,
          userModel: UserModel(
            id: '',
            fullName: '',
            photoUrl: '',
            email: '',
            createdAt: DateTime.now(),
          ),
          books: const [],
          totalPages: "",
          totalWords: "",
        )) {
    init();
  }

  final AuthLocalRepository _authLocalRepository;
  final AuthRepository _authRepository;
  final BookLocalRepository _bookLocalRepository;

  Future<void> init() async {
    emit(state.copyWith(status: ProfileStatus.LOADING));
    await currentUser();
    await getBooks();
    totalPages();
    totalWords();
    emit(state.copyWith(status: ProfileStatus.LOADED));
  }

  Future<void> currentUser() async {
    var userModel = await _authLocalRepository.currentUser();
    emit(state.copyWith(userModel: userModel));
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  Future<void> getBooks() async {
    List<BookModel> list = await _bookLocalRepository.getBooks();
    emit(state.copyWith(books: list));
  }

  void totalPages() {
    int total = 0;
    for (var e in state.books) {
      total = total + e.page;
    }
    emit(state.copyWith(totalPages: total.toString()));
  }

  void totalWords() {
    int total = 0;
    for (var e in state.books) {
      total = total + (e.page * 250);
    }
    emit(state.copyWith(totalWords: total.toString()));
  }
}
