import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit()
      : super(const AddBookState(
          status: AddBookStatus.INIT,
        ));
}
