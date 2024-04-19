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

  ////GET////
  //모든 재료 List 조회하기
  Future<List<Ingredient>> getIngredientList() async {
    Response response = await get(Uri.parse('$baseUrl/$getAllUrl'));
    if (response.statusCode == 200) {
      print("getList 200 OK");
      final List ingredients = jsonDecode(utf8.decode(response.bodyBytes));
      //final List ingredients = jsonDecode(response.body);
      return ingredients.map((e) => Ingredient.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //id로 재료 조회하기
  Future<Ingredient> getIngredient(String id) async {
    Response response = await get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      print("getId 200 OK");
      Ingredient ingredient = jsonDecode(utf8.decode(response.bodyBytes));
      return ingredient;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //모든 재료 갯수 가져오기
  Future<int> getIngredientCount() async {
    Response response = await get(Uri.parse('$baseUrl/count'));
    if (response.statusCode == 200) {
      print("getCount 200 OK");
      int count = jsonDecode(utf8.decode(response.bodyBytes));
      return count;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  ////POST////
  //재료 추가하기, 수정하기
  Future<dynamic> upsertIngredient(Ingredient ingredient) async {
    final Map<String, dynamic> requestBody = ingredient.toJson();
    Response response = await post(Uri.parse('$baseUrl/upsert'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to upsert ingredient: ${response.statusCode}');
    }
  }

  ////Delete////
  Future<void> deleteIngredient(int id) async {
    Response response = await delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode == 200) {
      print('Ingredient with id $id deleted successfully.');
    } else {
      throw Exception('Failed to delete ingredient: ${response.statusCode}');
    }
  }
}
