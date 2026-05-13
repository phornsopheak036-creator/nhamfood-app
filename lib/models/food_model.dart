class Food {
  final int id;
  final String name;
  final String description;
  final String image;
  final String category;
  final String origin;
  final String cookTime;
  final List<String> ingredients;
  final String recipe;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.origin,
    required this.cookTime,
    required this.ingredients,
    required this.recipe,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      origin: json['origin'] ?? '',
      cookTime: json['cook_time'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      recipe: json['recipe'] ?? '',
    );
  }
}
