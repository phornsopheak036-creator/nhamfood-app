import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  
  Future<Meal?> getRandomMeal() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/random.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        if (meals != null && meals.isNotEmpty) {
          return Meal.fromJson(meals[0]);
        }
      }
    } catch (e) {
      print('Error fetching random meal: $e');
    }
    return null;
  }


  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/categories.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final categories = data['categories'] as List?;
        if (categories != null) {
          return categories.map((c) => Category.fromJson(c)).toList();
        }
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
    return [];
  }

  
  Future<List<MealPreview>> getMealsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/filter.php?c=$category'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        if (meals != null) {
          return meals.map((m) => MealPreview.fromJson(m)).toList();
        }
      }
    } catch (e) {
      print('Error fetching meals by category: $e');
    }
    return [];
  }

  
  Future<List<MealPreview>> searchMeals(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search.php?s=${Uri.encodeComponent(query)}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        if (meals != null) {
          return meals.map((m) => MealPreview.fromJson(m)).toList();
        }
      }
    } catch (e) {
      print('Error searching meals: $e');
    }
    return [];
  }

 
  Future<Meal?> getMealById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/lookup.php?i=$id'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        if (meals != null && meals.isNotEmpty) {
          return Meal.fromJson(meals[0]);
        }
      }
    } catch (e) {
      print('Error fetching meal by id: $e');
    }
    return null;
  }

 
  Future<List<MealPreview>> getMealsByArea(String area) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/filter.php?a=$area'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        if (meals != null) {
          return meals.map((m) => MealPreview.fromJson(m)).toList();
        }
      }
    } catch (e) {
      print('Error fetching meals by area: $e');
    }
    return [];
  }


  Future<List<MealPreview>> getMealsByFirstLetter(String letter) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search.php?f=$letter'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        if (meals != null) {
          return meals.map((m) => MealPreview.fromJson(m)).toList();
        }
      }
    } catch (e) {
      print('Error fetching meals by letter: $e');
    }
    return [];
  }
}
