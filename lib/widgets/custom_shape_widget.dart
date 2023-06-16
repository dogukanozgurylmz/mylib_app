import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomShapeWidget1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffff9900)
      ..style = PaintingStyle.fill;

    final path = Path();

    final List<Offset> vertices = [
      Offset(size.width * .4, size.height * .3),
      Offset(size.width * .25, size.height * .45),
      Offset(size.width * .05, size.height * .35),
      Offset(size.width * .1, size.height * .15),
      Offset(size.width * .35, size.height * .1),
    ];

    path.moveTo(vertices[0].dx, vertices[0].dy);

    for (int i = 1; i < vertices.length; i++) {
      path.lineTo(vertices[i].dx, vertices[i].dy);
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomShapeWidget2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff273043)
      ..style = PaintingStyle.fill;

    final path = Path();

    final List<Offset> vertices = [
      Offset(size.width * 1.2, size.height * .7),
      Offset(size.width * .7, size.height * .9),
      Offset(size.width * .55, size.height * .7),
      Offset(size.width * .6, size.height * .6),
      Offset(size.width * .9, size.height * .5),
    ];

    path.moveTo(vertices[0].dx, vertices[0].dy);

    for (int i = 1; i < vertices.length; i++) {
      path.lineTo(vertices[i].dx, vertices[i].dy);
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomShapeWidget3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff9197AE)
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.2;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomShapeView extends StatefulWidget {
  const CustomShapeView({Key? key}) : super(key: key);

  @override
  _CustomShapeViewState createState() => _CustomShapeViewState();
}

class _CustomShapeViewState extends State<CustomShapeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final double shapeSize = 400.0; // Şekil boyutunu belirle
  double shapeX = 0.0;
  double shapeY = 0.0;

  @override
  void initState() {
    super.initState();

    // Animasyon kontrolcüsü oluştur
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Animasyonu tanımla
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          // Şeklin pozisyonunu güncelle
          shapeX = (MediaQuery.of(context).size.width - shapeSize) *
              _animation.value; // X koordinatı
          shapeY = (MediaQuery.of(context).size.height - shapeSize) *
              _animation.value; // Y koordinatı
        });
      });

    // Animasyonu sürekli olarak çalıştır
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleFullScreen() {
    final isFullScreen =
        _animationController.status == AnimationStatus.completed;
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
          overlays: SystemUiOverlay.values);
    }

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yamuk Şekli'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: CustomShapeWidget1(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          CustomPaint(
            painter: CustomShapeWidget2(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          GestureDetector(
            onTap: toggleFullScreen,
            child: Container(
              width: shapeSize,
              height: shapeSize,
              margin: EdgeInsets.only(left: shapeX, top: shapeY),
              child: CustomPaint(
                painter: CustomShapeWidget3(),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              backgroundBlendMode: BlendMode.srcOver,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0,
                sigmaY: 0,
              ),
              child: Container(
                color: Colors.transparent,
                child: Center(child: Text("data")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
