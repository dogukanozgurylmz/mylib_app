import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylib_app/repository/auth_repository.dart';
import 'package:mylib_app/repository/book_repository.dart';
import 'package:mylib_app/repository/bookcase_repository.dart';

import '../../../model/book_model.dart';
import '../../../model/bookcase_model.dart';
import '../../../model/user_model.dart';
import '../../../repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required AuthRepository authRepository,
    required BookRepository bookRepository,
    required BookcaseRepository bookcaseRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _bookRepository = bookRepository,
        _bookcaseRepository = bookcaseRepository,
        _userRepository = userRepository,
        super(HomeState(
          status: HomeStatus.INIT,
          userModel: UserModel(
            id: '',
            fullName: '',
            photoUrl: '',
            email: '',
            createdAt: DateTime.now(),
          ),
          books: const [],
          bookcases: const [],
        )) {
    init();
  }

  Future<void> init() async {
    emit(state.copyWith(status: HomeStatus.LOADING));
    await currentUser();
    await getBookcasesByUserId();
    await getBooksById();
    getDateData();
    emit(state.copyWith(status: HomeStatus.LOADED));
  }

  final AuthRepository _authRepository;
  final BookRepository _bookRepository;
  final BookcaseRepository _bookcaseRepository;
  final UserRepository _userRepository;

  Future<void> currentUser() async {
    var currentUser = _authRepository.currentUser();
    UserModel userModel =
        await _userRepository.getUserByEmail(currentUser!.email ?? "");

    emit(state.copyWith(
        userModel: UserModel(
      id: userModel.id,
      fullName: userModel.fullName,
      photoUrl: userModel.photoUrl,
      email: userModel.email,
      createdAt: userModel.createdAt,
    )));
  }

  Future<void> getBookcasesByUserId() async {
    List<BookcaseModel> list =
        await _bookcaseRepository.getBookcasesByUserId(state.userModel.id);
    emit(state.copyWith(bookcases: list));
  }

  Future<void> getBooksById() async {
    List<String> bookIds = [];
    for (var e in state.bookcases) {
      bookIds.addAll(e.bookIds);
    }
    List<BookModel> list = await _bookRepository.getBooksByIds(bookIds);
    List<BookModel> books = list.where((element) => element.isReading).toList();
    emit(state.copyWith(books: books));
  }

  List<ChartData> getDateData() {
    Map<String, int> bookCounts = {};

    for (BookModel book in state.books) {
      int year = book.endDate.year;
      int month = book.endDate.month;

      String key = '$year-$month';
      bookCounts[key] = (bookCounts[key] ?? 0) + 1;
    }

    List<ChartData> data = [];
    bookCounts.forEach((key, value) {
      List<String> parts = key.split('-');
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      data.add(ChartData(DateTime(year, month), value.toDouble()));
    });

    return data;
  }
}

class ChartData {
  DateTime category;
  double value;

  ChartData(this.category, this.value);
}
