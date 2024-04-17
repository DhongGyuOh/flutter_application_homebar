class Ingredient {
  String name;
  String detail;

  Ingredient({
    required this.name,
    required this.detail,
  });
}

class ingredient {
  int ingredientId;
  int categoryId;
  String name;
  String detail;
  String state;
  DateTime createdAt;
  ingredient({
    required this.ingredientId,
    required this.categoryId,
    required this.name,
    required this.detail,
    required this.state,
    required this.createdAt,
  });

  ingredient.fromJson(Map<String, dynamic> json)
      : ingredientId = json["ingredient_id"],
        categoryId = json["category_id"],
        name = json["name"],
        detail = json["detail"],
        state = json["state"],
        createdAt = json["created_at"];

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
