class Meal {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String? youtubeUrl;
  final String? tags;
  final List<String> ingredients;
  final List<String> measures;

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    this.youtubeUrl,
    this.tags,
    required this.ingredients,
    required this.measures,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString().trim());
        measures.add(measure?.toString().trim() ?? '');
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      youtubeUrl: json['strYoutube'],
      tags: json['strTags'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}

class MealPreview {
  final String id;
  final String name;
  final String thumbnail;

  MealPreview({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory MealPreview.fromJson(Map<String, dynamic> json) {
    return MealPreview(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
    );
  }
}

class Category {
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'] ?? '',
      name: json['strCategory'] ?? '',
      thumbnail: json['strCategoryThumb'] ?? '',
      description: json['strCategoryDescription'] ?? '',
    );
  }
}
