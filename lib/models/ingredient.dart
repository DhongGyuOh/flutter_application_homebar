class Ingredients {
  String name;
  String detail;

  Ingredients({
    required this.name,
    required this.detail,
  });
}

class Ingredient {
  int? ingredientId;
  int categoryId;
  String name;
  String detail;
  String state;
  DateTime createdAt;
  Ingredient({
    this.ingredientId,
    required this.categoryId, //옵셔널한 필드로 변경
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
    final Map<String, dynamic> data = {
      "category_id": categoryId,
      "name": name,
      "detail": detail,
      "state": state,
      //toIso8601String(): "2024-04-23T15:30:00Z" 형태로 변환
      "created_at": createdAt.toIso8601String(),
    };

    // ingredientId가 null이 아닌 경우에만 추가
    if (ingredientId != null) {
      data["ingredient_id"] = ingredientId;
    }

    return data;
  }
}
