import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterestScreen extends ConsumerStatefulWidget {
  static String routeName = "interest";
  static String routeURL = "/interest";
  const InterestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InterestScreenState();
}

class _InterestScreenState extends ConsumerState<InterestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
