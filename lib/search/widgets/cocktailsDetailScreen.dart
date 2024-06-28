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
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  late Future<CocktailsInfo> cocktailsInfo;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
    _animation = Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);
    _animation2 = Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);
    _animation3 = Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);

    cocktailsInfo = _fetchCocktailInfo();
  }

  Future<CocktailsInfo> _fetchCocktailInfo() async {
    return await ref
        .read(searchProvider.notifier)
        .getCocktailInfo(widget.cocktailId);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CocktailsInfo>(
        future: cocktailsInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final cocktail = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    width: DeviceSize.deviceWidth,
                    height: DeviceSize.deviceHeight / 2,
                    child: Column(
                      children: [
                        Text(cocktail.cocktailId.toString()),
                        Text(cocktail.nameEng),
                        Text(cocktail.name),
                        Text(cocktail.detail),
                        Text(cocktail.strength.toString()),
                        Text(cocktail.acidity.toString()),
                        Text(cocktail.sweetness.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cocktail.ingredientList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              cocktail.ingredientList![index].ingredientName),
                          subtitle: Text(cocktail
                              .ingredientList![index].recipeAmount
                              .toString()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
//   void _updateAnimations(CocktailsInfo cocktail) {
//     final newBegin = _animation.value;
//     setState(() {
//       _animation = Tween(begin: newBegin, end: cocktail.strength)
//           .animate(_curvedAnimation);
//       _animation2 = Tween(begin: newBegin, end: cocktail.acidity)
//           .animate(_curvedAnimation);
//       _animation3 = Tween(begin: newBegin, end: cocktail.sweetness)
//           .animate(_curvedAnimation);
//     });
//     _animationController.forward(from: 0);
//   }
// }

// class BalancePainter extends CustomPainter {
//   final double progress;
//   final double progress2;
//   final double progress3;
//   BalancePainter(
//       {required this.progress,
//       required this.progress2,
//       required this.progress3});
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center =
//         Offset(DeviceSize.deviceWidth / 2.5, DeviceSize.deviceHeight / 7);
//     const startingAngle = -0.5 * pi;
//     final redArcRect = Rect.fromCircle(center: center, radius: 70);
//     final redArcPaint = Paint()
//       ..color = Colors.pink
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 15;
//     canvas.drawArc(
//         redArcRect, startingAngle, progress * pi, false, redArcPaint);

//     final limeArcRect = Rect.fromCircle(center: center, radius: 50);
//     final limeArcPaint = Paint()
//       ..color = Colors.lime
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 15;
//     canvas.drawArc(
//         limeArcRect, startingAngle, progress2 * pi, false, limeArcPaint);

//     final indigoArcRect = Rect.fromCircle(center: center, radius: 30);
//     final indigoArcPaint = Paint()
//       ..color = Colors.indigo
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 15;
//     canvas.drawArc(
//         indigoArcRect, startingAngle, progress3 * pi, false, indigoArcPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
