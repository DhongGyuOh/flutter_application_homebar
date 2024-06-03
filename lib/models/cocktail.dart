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

class CocktailsInfo {
  final int cocktailId;
  final String name;
  final String nameEng;
  final String detail;
  final double sweetness;
  final double acidity;
  final double strength;
  final int state;
  final DateTime created_at;
  final int mixtypeId;
  final String? mixtypeName;
  final List<IngredientInfo>? ingredientList;

  CocktailsInfo({
    required this.cocktailId,
    required this.name,
    required this.nameEng,
    required this.detail,
    required this.sweetness,
    required this.acidity,
    required this.strength,
    required this.state,
    required this.created_at,
    required this.mixtypeId,
    required this.mixtypeName,
    required this.ingredientList,
  });

  // CocktailsInfo.fromJson(Map<String, dynamic> json)
  //     : cocktailId = json["cocktailId"],
  //       name = json["name"],
  //       nameEng = json["nameEng"],
  //       detail = json["detail"],
  //       sweetness = json["sweetness"].toDouble(),
  //       acidity = json["acidity"].toDouble(),
  //       strength = json["strength"].toDouble(),
  //       state = json["state"],
  //       mixtypeId = json["mixtype"],
  //       mixtypeName = json["mixtypeName"],
  //       ingredientList = (json["ingredientList"] as List)
  //           .map((i) => IngredientInfo.fromJson(i))
  //           .toList();

  factory CocktailsInfo.fromJson(Map<String, dynamic> json) {
    return CocktailsInfo(
      cocktailId: json['cocktailId'],
      name: json['name'],
      nameEng: json['nameEng'],
      detail: json['detail'],
      sweetness: json['sweetness'].toDouble(),
      acidity: json['acidity'].toDouble(),
      strength: json['strength'].toDouble(),
      state: json['state'],
      created_at: DateTime.parse(json['created_at']),
      mixtypeId: json['mixtypeId'],
      mixtypeName: json['mixtypeName'],
      ingredientList: (json['ingredientDTOList'] as List)
          .map((i) => IngredientInfo.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cocktailId': cocktailId,
      'name': name,
      'nameEng': nameEng,
      'detail': detail,
      'sweetness': sweetness,
      'acidity': acidity,
      'strength': strength,
      'state': state,
      'mixtypeId': mixtypeId,
      'mixtypeName': mixtypeName,
      'ingredientList': ingredientList?.map((i) => i.toJson()).toList(),
    };
  }
}

class IngredientInfo {
  final double recipeAmount;
  final int ingredientId;
  final String ingredientName;
  final String ingredientDetail;
  final int ingredientState;
  final int categoryId;
  final String categoryName;
  final String categoryUnit;

  IngredientInfo({
    required this.recipeAmount,
    required this.ingredientId,
    required this.ingredientName,
    required this.ingredientDetail,
    required this.ingredientState,
    required this.categoryId,
    required this.categoryName,
    required this.categoryUnit,
  });

  factory IngredientInfo.fromJson(Map<String, dynamic> json) {
    return IngredientInfo(
      recipeAmount: json['recipeAmount'].toDouble(),
      ingredientId: json['ingredientId'],
      ingredientName: json['ingredientName'],
      ingredientDetail: json['ingredientDetail'],
      ingredientState: json['ingredientState'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryUnit: json['categoryUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeAmount': recipeAmount,
      'ingredientId': ingredientId,
      'ingredientName': ingredientName,
      'ingredientDetail': ingredientDetail,
      'ingredientState': ingredientState,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryUnit': categoryUnit,
    };
  }
}
