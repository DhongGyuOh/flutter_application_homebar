import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String routeName = "home";
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final LiquidController _liquidController = LiquidController();
  final pages = [
    const LiquidPage(
        pageColor: Colors.red,
        lottieURL:
            "https://lottie.host/578475de-64fa-4651-bd17-e6b06e885050/GUIcISa6wn.json",
        pageTitle: "I'm the host of this party"),
    const LiquidPage(
        pageColor: Colors.orange,
        lottieURL:
            "https://lottie.host/96f50d0f-4db1-43dd-bc80-6b91b8ca10f1/1XWO9qPN4e.json",
        pageTitle: "I am a guest"),
    const LiquidPage(
        pageColor: Colors.amber,
        lottieURL:
            "https://lottie.host/7b1c3258-e207-43d6-8a4b-faf3a2120f3e/MlRAR7F7wg.json",
        pageTitle: "Recommend Foods"),
    const LiquidPage(
        pageColor: Colors.green,
        lottieURL:
            "https://lottie.host/68c7a614-62f4-4e7b-bc27-564d65bae5dd/ChZl1P8BIr.json",
        pageTitle: "Cocktail Quiz"),
    const LiquidPage(
        pageColor: Colors.blue,
        lottieURL:
            "https://lottie.host/5d1f6891-fbd4-4136-87d0-bcb67e926044/22xlYMmCWO.json",
        pageTitle: "Awards"),
    const LiquidPage(
        pageColor: Colors.indigo,
        lottieURL:
            "https://lottie.host/67432040-babe-48c4-8d21-d8a42b4a37ad/dA899YfSVG.json",
        pageTitle: "Drink Charts"),
    const LiquidPage(
        pageColor: Colors.purple,
        lottieURL:
            "https://lottie.host/4085714a-8caf-49ce-ad11-a507fc302d92/7v5Z1u7Bez.json",
        pageTitle: "Home Bar Skills"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Stack(
        children: [
          LiquidSwipe(
            liquidController: _liquidController,
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
        ],
      ),
    );
  }
}

class LiquidPage extends StatelessWidget {
  final Color pageColor;
  final String lottieURL;
  final String pageTitle;
  const LiquidPage(
      {super.key,
      required this.pageColor,
      required this.lottieURL,
      required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: pageColor),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.network(
            lottieURL,
            fit: BoxFit.cover,
          ),
          Text(
            pageTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      )),
    );
  }
}
