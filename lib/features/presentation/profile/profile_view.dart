// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylib_app/base/base_stateless.dart';
import 'package:mylib_app/features/data/datasource/local_repository/impl/book_local_datasource_impl.dart.dart';
import 'package:mylib_app/features/data/datasource/local_repository/impl/user_local_datasource_impl.dart';

import '../../data/repository/impl/auth_repository_impl.dart';
import 'cubit/profile_cubit.dart';

class ProfileView extends BaseBlocStateless<ProfileCubit, ProfileState> {
  const ProfileView({super.key});

  @override
  ProfileCubit createBloc(BuildContext context) {
    final UserLocalDatasourceImpl userLocalDatasourceImpl =
        UserLocalDatasourceImpl();
    final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
    final BookLocalDatasourceImpl bookLocalDatasourceImpl =
        BookLocalDatasourceImpl();
    return ProfileCubit(
      userLocalDatasourceImpl: userLocalDatasourceImpl,
      authRepositoryImpl: authRepositoryImpl,
      bookLocalDatasourceImpl: bookLocalDatasourceImpl,
    );
  }

  @override
  Widget buildBloc(BuildContext context, state) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var cubit = context.read<ProfileCubit>();
    switch (state.status) {
      case ProfileStatus.LOADED:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profil"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * .5,
                  width: MediaQuery.of(context).size.width * .5,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff9197AE).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xff9197AE).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xff9197AE).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.network(
                          state.userModel.photoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  state.userModel.fullName,
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xff273043),
                    ),
                    minimumSize:
                        MaterialStateProperty.all(Size(size.width, 40)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profili düzenle',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Container(
                        width: 70,
                        padding: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Color(0xff273043),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InfoContainer(
                    title: "Kitap", value: state.books.length.toString()),
                const SizedBox(height: 5),
                InfoContainer(title: "Sayfa", value: state.totalPages),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      await cubit.signOut();
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red[300],
                      ),
                    ),
                    child: Text(
                      'Çıkış yap',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case ProfileStatus.LOADING:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class InfoContainer extends StatelessWidget {
  final String title;
  final String value;

  const InfoContainer({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff9197AE)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff273043)),
          ),
          const VerticalDivider(
            endIndent: 5,
            indent: 5,
          ),
          const SizedBox(height: 5),
          SizedBox(width: 70, child: Text(title)),
        ],
      ),
    );
  }
}
