import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final controller = PageController(viewportFraction: 0.8, keepPage: false);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("myLib"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/profile");
            },
            borderRadius: BorderRadius.circular(45),
            child: const CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/1000"),
            ),
          ),
          const SizedBox(width: 10),
        ],
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/addbook");
        },
        backgroundColor: const Color(0xffFF9900),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Merhaba,",
                style: textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Doğukan Özgür",
                style: textTheme.headlineLarge!,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xffFF9900),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tutuanamayanlar",
                          style: textTheme.headlineSmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Oğuz Atay",
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
                      percent: 0.7,
                      center: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "10 Haziran",
                              style: textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "17 Haziran",
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
            CarouselSlider(
                items: [
                  Container(
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
                          "Polisiye Kitapları",
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "3 kitap",
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                          "Polisiye Kitapları",
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "3 kitap",
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                          "Polisiye Kitapları",
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "3 kitap",
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                )),
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
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    majorGridLines: const MajorGridLines(width: 0.5),
                    intervalType: DateTimeIntervalType.months,
                    dateFormat: DateFormat.MMM('tr_TR'),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    labelStyle: const TextStyle(color: Colors.black),
                    // visibleMinimum: previousMonth,
                    // visibleMaximum: nextMonth,
                  ),
                  primaryYAxis:
                      NumericAxis(minimum: 0, maximum: 10, interval: 2),
                  borderWidth: 0,
                  series: <ChartSeries>[
                    SplineSeries<ChartData, DateTime>(
                      dataSource: getData(),
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      color: const Color(0xff9197AE),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(enable: false),
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  List<ChartData> getData() {
    return <ChartData>[
      ChartData(DateTime(2023, 3), 3),
      ChartData(DateTime(2023, 4), 5),
      ChartData(DateTime(2023, 5), 4),
      ChartData(DateTime(2023, 6), 8),
    ];
  }
}

class ChartData {
  final DateTime category;
  final double value;

  ChartData(this.category, this.value);
}
