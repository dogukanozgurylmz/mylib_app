import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mylib_app/base/base_stateless.dart';
import 'package:mylib_app/features/data/datasource/local_repository/impl/user_local_datasource_impl.dart';

import '../../data/repository/impl/book_repository_impl.dart';
import '../../data/repository/impl/bookcase_repository_impl.dart';
import 'cubit/add_book_cubit.dart';

class AddBookView extends BaseBlocStateless<AddBookCubit, AddBookState> {
  const AddBookView({super.key});
  @override
  AddBookCubit createBloc(BuildContext context) {
    final BookRepositoryImpl bookRepositoryImpl = BookRepositoryImpl();
    final BookcaseRepositoryImpl bookcaseRepositoryImpl =
        BookcaseRepositoryImpl();
    final UserLocalDatasourceImpl userLocalDatasourceImpl =
        UserLocalDatasourceImpl();
    return AddBookCubit(
      bookRepositoryImpl: bookRepositoryImpl,
      bookcaseRepositoryImpl: bookcaseRepositoryImpl,
      userLocalDatasourceImpl: userLocalDatasourceImpl,
    );
  }

  @override
  Widget buildBloc(BuildContext context, AddBookState state) {
    var cubit = context.read<AddBookCubit>();
    switch (state.status) {
      case AddBookStatus.LOADED:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kitap ekle'),
            surfaceTintColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: cubit.formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: cubit.titleController,
                    decoration: InputDecoration(
                      labelText: 'Kitabın adı',
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
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: cubit.authorController,
                    decoration: InputDecoration(
                      labelText: 'Yazarı',
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
                        return 'Please enter an author';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: cubit.pageCountController,
                    decoration: InputDecoration(
                      labelText: 'Kaç sayfa',
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
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a page count';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      cubit.onTapStartDate(selectedDate!);
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Başlangıç tarihi',
                        labelStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide:
                              const BorderSide(color: Color(0xFF273043)),
                        ),
                      ),
                      child: Text(
                        state.startDate != null
                            ? DateFormat.yMMMd('tr_TR').format(state.startDate)
                            // ${state.startDate.day}/${state.startDate.month}/${state.startDate.year}
                            : 'Select a date',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      cubit.onTapEndDate(selectedDate!);
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Bitireceğin tarih',
                        labelStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45),
                          borderSide:
                              const BorderSide(color: Color(0xFF273043)),
                        ),
                      ),
                      child: Text(
                        state.endDate != null
                            ? DateFormat.yMMMd('tr_TR').format(state.endDate)
                            // ? '${_endDate.day}/${_endDate.month}/${_endDate.year}'
                            : 'Select a date',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: state.bookcases.first.title,
                    items: state.bookcases.map((bookcase) {
                      return DropdownMenuItem<String>(
                        value: bookcase.title,
                        child: Text(bookcase.title),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Kitaplık seç',
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
                    onChanged: (value) {
                      cubit.selectBookcase(value!);
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Lütfen kitaplık seç!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Şuan okuyorum"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Switch(
                      activeColor: const Color(0xff9197AE),
                      activeTrackColor: const Color(0xff273043),
                      inactiveThumbColor: const Color(0xff273043),
                      inactiveTrackColor: const Color(0xff9197AE),
                      value: state.isReading,
                      onChanged: (value) {
                        cubit.changeReading(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  state.isSubmit
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff273043),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: cubit.submitForm,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff273043),
                            ),
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
            ),
          ),
        );
      case AddBookStatus.LOADING:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      default:
        return const Scaffold(
          body: SizedBox.shrink(),
        );
    }
  }
}
