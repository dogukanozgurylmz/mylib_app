part of 'add_bookcase_cubit.dart';

enum AddBookcaseStatus {
  INIT,
  SUCCESS,
  ERROR,
  LOAD,
  LOADING,
}

class AddBookcaseState extends Equatable {
  final AddBookcaseStatus status;

  const AddBookcaseState({
    required this.status,
  });
  AddBookcaseState copyWith({
    AddBookcaseStatus? status,
  }) {
    return AddBookcaseState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
