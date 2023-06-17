import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylib_app/base/base_stateless.dart';
import 'package:mylib_app/features/data/datasource/local_repository/impl/user_local_datasource_impl.dart';
import 'package:mylib_app/features/data/repository/impl/bookcase_repository_impl.dart';

import 'cubit/add_bookcase_cubit.dart';

class AddBookcaseView
    extends BaseBlocStateless<AddBookcaseCubit, AddBookcaseState> {
  const AddBookcaseView({super.key});

  @override
  AddBookcaseCubit createBloc(BuildContext context) {
    final UserLocalDatasourceImpl userLocalDatasourceImpl =
        UserLocalDatasourceImpl();
    final BookcaseRepositoryImpl bookcaseRepositoryImpl =
        BookcaseRepositoryImpl();
    return AddBookcaseCubit(
      userLocalDatasourceImpl: userLocalDatasourceImpl,
      bookcaseRepositoryImpl: bookcaseRepositoryImpl,
    );
  }

  @override
  Widget buildBloc(BuildContext context, state) {
    var cubit = context.read<AddBookcaseCubit>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitaplık ekle"),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: cubit.titleController,
              decoration: InputDecoration(
                labelText: 'Kitaplığın adı',
                labelStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(45),
                  borderSide: const BorderSide(color: Color(0xFF273043)),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            state.isSubmit
                ? const CircularProgressIndicator(
                    color: Color(0xff273043),
                  )
                : ElevatedButton(
                    onPressed: () {
                      cubit.submitForm().whenComplete(
                            () => Navigator.of(context).pop(),
                          );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff273043),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(Size(size.width, 40)),
                    ),
                    child: Text(
                      'Ekle',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
