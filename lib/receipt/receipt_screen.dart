import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceiptScreen extends ConsumerStatefulWidget {
  static String routeName = "receipt";
  static String routeURL = "/receipt";
  const ReceiptScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends ConsumerState<ReceiptScreen> {
  final Map<String, dynamic> orderList = {
    "Old Fashioned": "10,000",
    "Gin Tonic": "8,500",
    "Lemon Sour": "8,000",
    "Tequila Shot": "7,500",
    "Zero Coke": "3,000",
    "Margarita": "9,500",
    "Daiquiri": "8,500",
    "Tom Collins": "9,000",
    "Piña Colada": "11,500",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
          child: ListView.separated(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final drinkName = orderList.keys.elementAt(index);
          final price = orderList[drinkName];
          return ListTile(
              title: Text(price),
              subtitle: Text(drinkName),
              leading: const Icon(FontAwesomeIcons.martiniGlass),
              trailing: const Icon(Icons.arrow_forward_ios));
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      )),
    );
  }
}
