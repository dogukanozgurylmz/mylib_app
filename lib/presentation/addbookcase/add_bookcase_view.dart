import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylib_app/base/base_stateless.dart';
import 'package:mylib_app/presentation/addbookcase/cubit/add_bookcase_cubit.dart';
import 'package:mylib_app/repository/bookcase_repository.dart';

import '../../repository/local_repository/auth_local_repository.dart';

class AddBookcaseView
    extends BaseBlocStateless<AddBookcaseCubit, AddBookcaseState> {
  const AddBookcaseView({super.key});

  @override
  AddBookcaseCubit createBloc(BuildContext context) {
    final AuthLocalRepository authLocalRepository = AuthLocalRepository();
    final BookcaseRepository bookcaseRepository = BookcaseRepository();
    return AddBookcaseCubit(
      authLocalRepository: authLocalRepository,
      bookcaseRepository: bookcaseRepository,
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
            ElevatedButton(
              onPressed: cubit.submitForm,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff273043),
                ),
                minimumSize: MaterialStateProperty.all(Size(size.width, 40)),
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
