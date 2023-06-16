import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mylib_app/model/user_model.dart';
import 'package:mylib_app/presentation/addbook/book_add_view.dart';
import 'package:mylib_app/presentation/home/cubit/home_cubit.dart';
import 'package:mylib_app/repository/local_repository/book_local_repository.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../base/base_stateless.dart';
import '../../providers/bookcase_provider.dart';
import '../../repository/auth_repository.dart';
import '../../repository/book_repository.dart';
import '../../repository/bookcase_repository.dart';
import '../../repository/user_repository.dart';

class HomeView extends BaseBlocStateless<HomeCubit, HomeState> {
  HomeView({Key? key}) : super(key: key);
  final AuthRepository _authRepository = AuthRepository();
  final BookRepository _bookRepository = BookRepository();
  final BookcaseRepository _bookcaseRepository = BookcaseRepository();
  final UserRepository _userRepository = UserRepository();
  final BookLocalRepository _bookLocalRepository = BookLocalRepository();

  @override
  HomeCubit createBloc(BuildContext context) {
    return HomeCubit(
      authRepository: _authRepository,
      bookRepository: _bookRepository,
      bookcaseRepository: _bookcaseRepository,
      userRepository: _userRepository,
      bookLocalRepository: _bookLocalRepository,
    );
  }

  @override
  Widget buildBloc(BuildContext context, HomeState state) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    var userModel = state.userModel;
    var cubit = context.read<HomeCubit>();
    switch (state.status) {
      case HomeStatus.LOADED:
        var now = DateTime.now();
        DateTime starterDate = state.books.first.starterDate;
        DateTime endDate = state.books.first.endDate;
        int totalDays = endDate.difference(starterDate).inDays;
        int middle = now.difference(starterDate).inDays;
        double ratio = middle / totalDays;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(context, userModel),
          floatingActionButton: const FAB(),
          body: RefreshIndicator(
            onRefresh: () async {
              await cubit.init();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Merhaba,",
                      style: textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      userModel.fullName,
                      style: textTheme.headlineMedium!,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Animate()
                      .custom(
                        duration: 2.seconds,
                        begin: 0,
                        end: 10,
                        builder: (_, value, __) => ReadingBookWidget(
                          size: size,
                          textTheme: textTheme,
                          ratio: ratio,
                          starterDate: starterDate,
                          endDate: endDate,
                          state: state,
                        ),
                      )
                      .moveX(
                        begin: -size.width,
                        end: 0,
                        duration: const Duration(milliseconds: 100),
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.easeInCirc,
                      ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Kitaplıklarım",
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Animate()
                      .custom(
                        builder: (_, value, __) => BookcaseWidget(
                          size: size,
                          textTheme: textTheme,
                          state: state,
                        ),
                      )
                      .blur(
                        begin: const Offset(30, 30),
                        end: const Offset(0, 0),
                        duration: const Duration(milliseconds: 100),
                        delay: const Duration(milliseconds: 100),
                        curve: Curves.easeInCirc,
                      ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Kitap özetleri",
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kitap adı",
                          style: textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Özeti",
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "İstatistik",
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  StatisticWidget(size: size),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        );
      case HomeStatus.LOADING:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  AppBar _appBar(BuildContext context, UserModel userModel) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text("myLib"),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/profile");
          },
          borderRadius: BorderRadius.circular(45),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userModel.photoUrl),
          ),
        ),
        const SizedBox(width: 10),
      ],
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }
}

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/statistic'),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xff273043).withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        height: 200,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            SizedBox(
              width: size.width * .5,
              height: size.width * .5,
              child: SfCircularChart(
                series: <RadialBarSeries<ChartData, int>>[
                  RadialBarSeries<ChartData, int>(
                    useSeriesColor: true,
                    trackOpacity: 0.3,
                    cornerStyle: CornerStyle.bothCurve,
                    dataSource: cubit.getDateData(),
                    pointRadiusMapper: (ChartData data, _) =>
                        DateFormat.MMMM('tr_TR').format(data.category),
                    pointColorMapper: (ChartData data, _) =>
                        const Color(0xff273043),
                    xValueMapper: (ChartData data, _) => data.value.toInt(),
                    yValueMapper: (ChartData date, _) => date.value.toInt(),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                    ),
                    dataLabelMapper: (ChartData data, _) =>
                        '${DateFormat.MMMM('tr_TR').format(data.category)} - ${data.value.toInt()}',
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_right,
              color: Color(0xff273043),
              size: 36,
            ),
          ],
        ),
      ),
    );
  }
}

class BookcaseWidget extends StatelessWidget {
  const BookcaseWidget({
    super.key,
    required this.size,
    required this.textTheme,
    required this.state,
  });

  final Size size;
  final TextTheme textTheme;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        final bookcase = state.bookcases[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/bookcasedetails', arguments: bookcase);
          },
          child: Container(
            height: 100,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xff273043),
              borderRadius: BorderRadius.circular(45),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bookcase.title,
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${bookcase.bookIds.length} kitap",
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 100,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: state.bookcases.length,
    );
  }
}

class ReadingBookWidget extends StatelessWidget {
  const ReadingBookWidget({
    super.key,
    required this.size,
    required this.textTheme,
    required this.ratio,
    required this.starterDate,
    required this.endDate,
    required this.state,
  });

  final Size size;
  final TextTheme textTheme;
  final double ratio;
  final DateTime starterDate;
  final DateTime endDate;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 90,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: const BoxDecoration(
              color: Color(0xffFF9900),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.books.first.bookName,
                  style: textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  state.books.first.author,
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * 0.85,
              animation: true,
              lineHeight: 24.0,
              animationDuration: 1000,
              percent: ratio > 1 ? 1 : ratio,
              center: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.MMMMd('tr_TR').format(starterDate),
                      style: textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      DateFormat.MMMMd('tr_TR').format(endDate),
                      style: textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              barRadius: const Radius.circular(30),
              progressColor: const Color(0xffFF9900),
              alignment: MainAxisAlignment.center,
              animateFromLastPercent: true,
              backgroundColor: const Color(0xffFFD699),
            ),
          ),
        ],
      ),
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pushNamed('/addbookcase');
                },
                child: const Text("Kitaplık ekle"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pushNamed('/addbook');
                },
                child: const Text("Kitap ekle"),
              ),
              CupertinoActionSheetAction(
                /// This parameter indicates the action would perform
                /// a destructive action such as delete or exit and turns
                /// the action's text color to red.
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("İptal"),
              ),
            ],
          ),
        );
        // Navigator.of(context).pushNamed('/addbook');
      },
      backgroundColor: const Color(0xffFF9900),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
