import 'package:flutter_application_homebar/models/ingredient.dart';
import 'package:flutter_application_homebar/models/whisky.dart';

class Cocktail {
  String name;
  double proof;
  String detail;
  List<Map<Whisky, double>> whisky;
  List<Map<Ingredients, double>> ingredient;
  Cocktail(
      {required this.name,
      required this.proof,
      required this.whisky,
      required this.ingredient,
      required this.detail});
}
