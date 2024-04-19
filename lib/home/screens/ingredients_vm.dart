import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_homebar/models/ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final ingredientProvider =
    AsyncNotifierProvider<IngredientsViewModel, List<Ingredient>>(
  () => IngredientsViewModel(),
);

class IngredientsViewModel extends AsyncNotifier<List<Ingredient>> {
  final String baseUrl = "http://172.17.7.232:8080/ing";
  final String getAllUrl = "all";
  @override
  FutureOr<List<Ingredient>> build() async {
    List<Ingredient> ingList = await getIngredientList();
    return ingList;
  }

  Future<List<Ingredient>> getIngredientList() async {
    Response response = await get(Uri.parse('$baseUrl/$getAllUrl'));
    if (response.statusCode == 200) {
      print("200 OK");
      final List ingredients = jsonDecode(utf8.decode(response.bodyBytes));
      //final List ingredients = jsonDecode(response.body);
      return ingredients.map((e) => Ingredient.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
