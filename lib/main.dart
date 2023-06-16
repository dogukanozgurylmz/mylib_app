import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mylib_app/model/book_model.dart';
import 'package:mylib_app/model/user_model.dart';
import 'package:mylib_app/model_adapters/book_model_adapter.dart';
import 'package:mylib_app/presentation/addbook/book_add_view.dart';
import 'package:mylib_app/presentation/addbookcase/add_bookcase_view.dart';
import 'package:mylib_app/presentation/bookcase_details/bookcase_details_view.dart';
import 'package:mylib_app/presentation/home/home_view.dart';
import 'package:mylib_app/presentation/profile/profile_view.dart';
import 'package:mylib_app/presentation/splash/splash_view.dart';
import 'package:mylib_app/presentation/statistic/statistic_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model_adapters/user_model_adapters.dart';
import 'presentation/signin/sign_in_view.dart';

Future<void> main() async {
  await initializeDateFormatting('tr_TR', null);
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Hive.initFlutter();
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  Hive.registerAdapter<BookModel>(BookModelAdapter());
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
        '/addbook': (context) => AddBookView(),
        '/profile': (context) => ProfileView(),
        '/addbookcase': (context) => const AddBookcaseView(),
        '/bookcasedetails': (context) => const BookcaseDetailsView(),
        '/statistic': (context) => const StatisticView(),
        // '/custompainter': (context) => const CustomShapeView(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Bir şeyler ters gitti'),
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
