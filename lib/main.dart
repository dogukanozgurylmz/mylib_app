import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mylib_app/presentation/addbook/book_add_view.dart';
import 'package:mylib_app/presentation/home/home_view.dart';
import 'package:mylib_app/presentation/profile/profile_view.dart';
import 'package:mylib_app/presentation/splash/splash_view.dart';

import 'firebase_options.dart';
import 'presentation/signin/sign_in_view.dart';

Future<void> main() async {
  await initializeDateFormatting('tr_TR', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // İlk açılışta SplashView sayfasını açar
      routes: {
        '/': (context) => SplashView(),
        '/home': (context) => HomeView(),
        '/signin': (context) => SignInView(),
        '/addbook': (context) => const AddBookView(),
        '/profile': (context) => const ProfileView(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Birşeyler ters gitti'),
          ),
        ),
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
