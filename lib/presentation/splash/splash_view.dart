import 'package:flutter/material.dart';
import 'package:mylib_app/presentation/signin/sign_in_view.dart';
import 'package:mylib_app/presentation/home/home_view.dart';

import '../../repository/auth_repository.dart';

class SplashView extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = _authRepository.currentUser();
    if (currentUser == null) {
      return SignInView();
    } else {
      return HomeView();
    }
  }
}
