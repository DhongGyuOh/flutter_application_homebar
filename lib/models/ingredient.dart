class Ingredients {
  String name;
  String detail;

  Ingredients({
    required this.name,
    required this.detail,
  });
}

class Ingredient {
  int ingredientId;
  int categoryId;
  String name;
  String detail;
  String state;
  DateTime createdAt;
  Ingredient({
    required this.ingredientId,
    required this.categoryId,
    required this.name,
    required this.detail,
    required this.state,
    required this.createdAt,
  });

  Ingredient.fromJson(Map<String, dynamic> json)
      : ingredientId = json["ingredient_id"],
        categoryId = json["category_id"],
        name = json["name"],
        detail = json["detail"],
        state = json["state"],
        createdAt = DateTime.parse(json["created_at"]); //DATETIME형으로 고침

  Map<String, dynamic> toJson() {
    return {
      "ingredient_id": ingredientId,
      "category_id": categoryId,
      "name": name,
      "detail": detail,
      "state": state,
      "created_at": createdAt,
    };
  }
}
