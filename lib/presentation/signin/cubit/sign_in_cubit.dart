import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylib_app/model/user_model.dart';
import 'package:mylib_app/repository/auth_repository.dart';
import 'package:mylib_app/repository/local_repository/auth_local_repository.dart';
import 'package:mylib_app/repository/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required AuthLocalRepository authLocalRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _authLocalRepository = authLocalRepository,
        super(const SignInState(
          status: SignInStatus.INIT,
        ));

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthLocalRepository _authLocalRepository;

  Future<void> signInWithGoogle() async {
    // Box<UserModel> box = await Hive.openBox<UserModel>('users');
    // box.clear();
    emit(state.copyWith(status: SignInStatus.LOADING));
    var user = await _authRepository.signInWithGoogle();

    if (user != null) {
      await _authLocalRepository.clear();
      var usermodel = await _userRepository.getUserByEmail(user.email ?? "");
      if (usermodel.email.isNotEmpty) {
        _authLocalRepository.create(usermodel);
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
      _authLocalRepository.create(userModel);
      emit(state.copyWith(status: SignInStatus.LOADED));
    } else {
      emit(state.copyWith(status: SignInStatus.ERROR));
    }
  }

  void resetSignInStatus() {
    emit(state.copyWith(status: SignInStatus.INIT));
  }
}
