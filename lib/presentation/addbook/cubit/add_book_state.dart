part of 'add_book_cubit.dart';

enum AddBookStatus {
  INIT,
  LOADING,
  LOADED,
}

class AddBookState extends Equatable {
  final AddBookStatus status;

  const AddBookState({
    required this.status,
  });

  AddBookState copyWith({
    AddBookStatus? status,
  }) {
    return AddBookState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [];
}
