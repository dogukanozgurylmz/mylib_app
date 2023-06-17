import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylib_app/base/base_stateless.dart';
import 'package:mylib_app/features/data/datasource/local_repository/impl/user_local_datasource_impl.dart';

import '../../data/repository/impl/auth_repository_impl.dart';
import '../../data/repository/impl/user_repository_impl.dart';
import 'cubit/sign_in_cubit.dart';

class SignInView extends BaseBlocStateless {
  const SignInView({Key? key}) : super(key: key);

  @override
  BlocBase createBloc(BuildContext context) {
    final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
    final UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
    final UserLocalDatasourceImpl userLocalDatasourceImpl =
        UserLocalDatasourceImpl();
    return SignInCubit(
      authRepositoryImpl: authRepositoryImpl,
      userRepositoryImpl: userRepositoryImpl,
      userLocalDatasourceImpl: userLocalDatasourceImpl,
    );
  }

  @override
  Widget buildBloc(BuildContext context, state) {
    var size = MediaQuery.of(context).size;
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
  }
}
