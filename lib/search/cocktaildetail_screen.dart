import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/constants/device_size.dart';
import 'package:flutter_application_homebar/search/search_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CocktailDetailScreen extends ConsumerStatefulWidget {
  static String routeName = "searchdetails";
  static String routeURL = "searchdetails";
  final String cocktailname;
  const CocktailDetailScreen({super.key, required this.cocktailname});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchDetailScreenState();
}

class _SearchDetailScreenState extends ConsumerState<CocktailDetailScreen>
    with SingleTickerProviderStateMixin {
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
  @override
  void initState() {
    _animationController.addListener(() {});
    _animationController.addStatusListener((status) {});
    _animateValues();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateValues() {
    final newBegin = _animation.value;
    final random = Random();
    final random2 = Random();
    final random3 = Random();
    final newEnd = random.nextDouble() * 2.0;
    final newEnd2 = random2.nextDouble() * 2.0;
    final newEnd3 = random3.nextDouble() * 2.0;
    setState(() {
      _animation =
          Tween(begin: newBegin, end: newEnd).animate(_curvedAnimation);
      _animation2 =
          Tween(begin: newBegin, end: newEnd2).animate(_curvedAnimation);
      _animation3 =
          Tween(begin: newBegin, end: newEnd3).animate(_curvedAnimation);
    });
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final cocktailInfo =
        ref.read(searchProvider.notifier).getCocktail(widget.cocktailname)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Cocktail Recipe"),
      ),
      body: Hero(
        tag: cocktailInfo,
        child: Material(
          type: MaterialType.transparency,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: DeviceSize.deviceHeight / 2,
                      width: DeviceSize.deviceWidth,
                      child: Image.network(
                        "https://loremflickr.com/200/350/cocktail",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      width: DeviceSize.deviceWidth,
                      height: DeviceSize.deviceHeight / 2,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cocktailInfo.name,
                              style: const TextStyle(fontSize: 40),
                            ),
                            Text(
                              cocktailInfo.proof.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            Stack(
                              children: [
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return CustomPaint(
                                      painter: BalancePainter(
                                        progress: _animation.value,
                                        progress2: _animation2.value,
                                        progress3: _animation3.value,
                                      ),
                                    );
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 50, right: 120),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Spicy",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pink),
                                      ),
                                      Text(
                                        "Sweet",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lime),
                                      ),
                                      Text(
                                        "Body",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 130, left: 30, right: 30),
                              child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(cocktailInfo.detail)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "Whisky List",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: DeviceSize.deviceWidth,
                  height: DeviceSize.deviceHeight / 6,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: cocktailInfo.whisky.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final whiskyList = cocktailInfo.whisky;
                      final whisky = whiskyList.elementAt(index);
                      final whiskyName = whisky.keys.first.name;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.pink,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://loremflickr.com/200/350/cocktail",
                            ),
                          ),
                        ),
                        child: Text(whiskyName),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      width: 5,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Ingredient List",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: DeviceSize.deviceWidth,
                  height: DeviceSize.deviceHeight / 6,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: cocktailInfo.ingredient.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final whiskyList = cocktailInfo.ingredient;
                      final ingredients = whiskyList.elementAt(index);
                      final ingredientName = ingredients.keys.first.name;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://loremflickr.com/200/350/cocktail",
                            ),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.orange,
                        ),
                        child: Text(ingredientName),
                      );
                    },
                    separatorBuilder: (context, index) => Container(width: 5),
                  ),
                )
              ],
            ),
          ),
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
    return true;
  }
}
