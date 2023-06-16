import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylib_app/presentation/signin/cubit/sign_in_cubit.dart';
import 'package:mylib_app/repository/local_repository/auth_local_repository.dart';
import 'package:mylib_app/repository/user_repository.dart';

import '../../repository/auth_repository.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);

  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();
  final AuthLocalRepository _authLocalRepository = AuthLocalRepository();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignInCubit(
        authRepository: _authRepository,
        userRepository: _userRepository,
        authLocalRepository: _authLocalRepository,
      ),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          var cubit = context.read<SignInCubit>();
          switch (state.status) {
            case SignInStatus.LOADED:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed('/home');
              });
              return const Scaffold(body: SizedBox.shrink());
            case SignInStatus.INIT:
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset('assets/logo/myliblogo.png'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await cubit.signInWithGoogle();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff273043),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size(size.width, 40),
                          ),
                        ),
                        child: Text(
                          'Google',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            case SignInStatus.LOADING:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case SignInStatus.ERROR:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Hata"),
                    content: const Text(
                      "Giriş yapılırken bir hata oluştu. Tekrar deneyin.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          cubit.resetSignInStatus();
                        },
                        child: const Text("Tamam"),
                      ),
                    ],
                  ),
                );
              });
              return const Scaffold(body: SizedBox.shrink());
            default:
              return const Scaffold(
                body: Center(
                  child: Text("Bir hata oluştu."),
                ),
              );
          }
        },
      ),
    );
  }
}
