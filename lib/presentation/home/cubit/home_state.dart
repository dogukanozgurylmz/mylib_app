part of 'home_cubit.dart';

enum HomeStatus {
  INIT,
  SUCCESS,
  ERROR,
  LOADED,
  LOADING,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final UserModel userModel;
  final List<BookModel> books;
  final List<BookcaseModel> bookcases;

  const HomeState({
    required this.status,
    required this.userModel,
    required this.books,
    required this.bookcases,
  });

  HomeState copyWith({
    HomeStatus? status,
    UserModel? userModel,
    List<BookModel>? books,
    List<BookcaseModel>? bookcases,
  }) {
    return HomeState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      books: books ?? this.books,
      bookcases: bookcases ?? this.bookcases,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userModel,
        books,
        bookcases,
      ];
}
