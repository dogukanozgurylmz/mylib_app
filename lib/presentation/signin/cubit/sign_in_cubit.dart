import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylib_app/model/user_model.dart';
import 'package:mylib_app/repository/auth_repository.dart';
import 'package:mylib_app/repository/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const SignInState(
          status: SignInStatus.INIT,
        ));

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: SignInStatus.LOADING));
    var user = await _authRepository.signInWithGoogle();

    if (user != null) {
      var usermodel = await _userRepository.getUserByEmail(user.email ?? "");
      if (usermodel.email.isNotEmpty) {
        emit(state.copyWith(status: SignInStatus.LOADED));
        return;
      }
      UserModel userModel = UserModel(
        id: '',
        fullName: user.displayName ?? "",
        photoUrl: user.photoURL ?? "",
        email: user.email ?? "",
        createdAt: DateTime.now(),
      );
      await _userRepository.createUser(userModel);
      emit(state.copyWith(status: SignInStatus.LOADED));
    } else {
      emit(state.copyWith(status: SignInStatus.ERROR));
    }
  }

  void resetSignInStatus() {
    emit(state.copyWith(status: SignInStatus.INIT));
  }
}
