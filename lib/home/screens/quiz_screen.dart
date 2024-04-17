import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizScreen extends ConsumerStatefulWidget {
  static String routeName = "quiz";
  static String routeURL = "/quiz";
  const QuizScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page == null) return;
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changePage(int newPage) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: PageView.builder(
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(45)),
                clipBehavior: Clip.hardEdge,
              ),
            ),
          )
        ],
      ),
    );
  }
}
