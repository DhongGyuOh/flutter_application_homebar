import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String routeName = "home";
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final LiquidController _liquidController = LiquidController();
  final pages = [
    Container(
      decoration: const BoxDecoration(color: Colors.red),
      child: const Center(
          child: Text(
        "I'm the host of this party",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )),
    ),
    Container(
      decoration: const BoxDecoration(color: Colors.orange),
      child: const Center(
          child: Text(
        "I am a guest",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )),
    ),
    Container(
      decoration: const BoxDecoration(color: Colors.yellow),
      child: const Center(
          child: Text(
        "Recommend Foods",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )),
    ),
    Container(
      decoration: const BoxDecoration(color: Colors.green),
      child: const Center(
          child: Text(
        "Cocktail Quiz",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )),
    ),
    Container(
      decoration: const BoxDecoration(color: Colors.blue),
      child: const Center(
          child: Text(
        "Awards",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )),
    ),
    Container(
      decoration: const BoxDecoration(color: Colors.indigo),
      child: const Center(
          child: Text(
        "Drink Charts",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )),
    ),
    Container(
      decoration: const BoxDecoration(color: Colors.purple),
      child: const Center(
          child: Text(
        "Home Bar Skills",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      )),
    )
  ];
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500));
  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 1.0).animate(_animationController);

  void _onPageChangeCallback(int nextPage) {
    if (nextPage != _liquidController.currentPage) {
      setState(() {
        _animationController.forward(from: 0.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Stack(
        children: [
          LiquidSwipe(
            liquidController: _liquidController,
            onPageChangeCallback: _onPageChangeCallback,
            pages: pages,
            waveType: WaveType.liquidReveal,
            fullTransitionValue: 600,
            positionSlideIcon: 0.8,
            preferDragFromRevealedArea: true,
            enableLoop: true,
            ignoreUserGestureWhileAnimating: true,
            enableSideReveal: true,
            slideIconWidget: const Icon(Icons.keyboard_double_arrow_left_sharp),
          ),
          IgnorePointer(
            child: LottieBuilder.network(
                fit: BoxFit.fill,
                controller: _animationController,
                'https://lottie.host/8e9a99c9-2e80-4e3f-86b8-591dba8b326c/iWLHkxpWKL.json'),
          )
        ],
      ),
    );
  }
}
