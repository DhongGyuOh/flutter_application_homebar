import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/constants/device_size.dart';
import 'package:flutter_application_homebar/models/cocktail.dart';
import 'package:flutter_application_homebar/search/search_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CocktailsDetailScreen extends ConsumerStatefulWidget {
  final int cocktailId;
  const CocktailsDetailScreen({required this.cocktailId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CocktailsDetailScreenState();
}

class _CocktailsDetailScreenState extends ConsumerState<CocktailsDetailScreen>
    with SingleTickerProviderStateMixin {
  late CocktailsInfo cocktailsInfo;
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..forward();

  late final CurvedAnimation _curvedAnimation = CurvedAnimation(
      parent: _animationController, curve: Curves.fastOutSlowIn);
  late Animation<double> _animation =
      Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);
  late Animation<double> _animation2 =
      Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);
  late Animation<double> _animation3 =
      Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);

  void getCocktailsInfo() async {
    cocktailsInfo = await ref
        .read(searchProvider.notifier)
        .getCocktailInfo(widget.cocktailId);
  }

  @override
  void initState() {
    _animationController.addListener(() {});
    _animationController.addStatusListener(
      (status) {},
    );
    getCocktailsInfo();
    final newBegin = _animation.value;
    final newEnd = cocktailsInfo.strength;
    final newEnd2 = cocktailsInfo.acidity;
    final newEnd3 = cocktailsInfo.sweetness;
    setState(() {
      _animation =
          Tween(begin: newBegin, end: newEnd).animate(_curvedAnimation);
      _animation2 =
          Tween(begin: newBegin, end: newEnd2).animate(_curvedAnimation);
      _animation3 =
          Tween(begin: newBegin, end: newEnd3).animate(_curvedAnimation);
    });
    _animationController.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class BalancePainter extends CustomPainter {
  final double progress;
  final double progress2;
  final double progress3;
  BalancePainter(
      {required this.progress,
      required this.progress2,
      required this.progress3});
  @override
  void paint(Canvas canvas, Size size) {
    final center =
        Offset(DeviceSize.deviceWidth / 2.5, DeviceSize.deviceHeight / 7);
    const startingAngle = -0.5 * pi;
    final redArcRect = Rect.fromCircle(center: center, radius: 70);
    final redArcPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15;
    canvas.drawArc(
        redArcRect, startingAngle, progress * pi, false, redArcPaint);

    final limeArcRect = Rect.fromCircle(center: center, radius: 50);
    final limeArcPaint = Paint()
      ..color = Colors.lime
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15;
    canvas.drawArc(
        limeArcRect, startingAngle, progress2 * pi, false, limeArcPaint);

    final indigoArcRect = Rect.fromCircle(center: center, radius: 30);
    final indigoArcPaint = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15;
    canvas.drawArc(
        indigoArcRect, startingAngle, progress3 * pi, false, indigoArcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
