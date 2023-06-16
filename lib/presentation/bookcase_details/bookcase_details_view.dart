import 'package:flutter/material.dart';
import 'package:mylib_app/model/bookcase_model.dart';
import 'package:provider/provider.dart';

import '../../providers/bookcase_provider.dart';

class BookcaseDetailsView extends StatelessWidget {
  const BookcaseDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bookcase =
        ModalRoute.of(context)!.settings.arguments as BookcaseModel;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(bookcase.title),
      ),
      body: ListView.builder(
        itemCount: bookcase.bookIds.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            width: size.width,
            child: Row(
              children: [
                const VerticalDivider(
                  indent: 5,
                  endIndent: 5,
                  color: Color(0xffFF9900),
                  thickness: 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Kitabın adı",
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      "Kitabın yazarı",
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios),
                const SizedBox(width: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}
