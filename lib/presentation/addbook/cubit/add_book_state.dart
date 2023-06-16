part of 'add_book_cubit.dart';

enum AddBookStatus {
  INIT,
  LOADING,
  LOADED,
}

class AddBookState extends Equatable {
  final AddBookStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final List<BookcaseModel> bookcases;
  final String selectedBookcase;

  const AddBookState({
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.bookcases,
    required this.selectedBookcase,
  });

  AddBookState copyWith({
    AddBookStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    List<BookcaseModel>? bookcases,
    String? selectedBookcase,
  }) {
    return AddBookState(
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      bookcases: bookcases ?? this.bookcases,
      selectedBookcase: selectedBookcase ?? this.selectedBookcase,
    );
  }

  @override
  List<Object?> get props => [
        status,
        startDate,
        endDate,
        bookcases,
        selectedBookcase,
      ];
}
