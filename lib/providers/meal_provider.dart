import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';

class MealProvider extends ChangeNotifier {
  final MealService _service = MealService();


  Meal? _randomMeal;
  List<Category> _categories = [];
  List<MealPreview> _featuredMeals = [];
  bool _homeLoading = false;
  String? _homeError;

  
  List<MealPreview> _categoryMeals = [];
  String _selectedCategory = '';
  bool _categoryLoading = false;


  List<MealPreview> _searchResults = [];
  bool _searchLoading = false;
  String _searchQuery = '';


  Meal? _selectedMeal;
  bool _detailLoading = false;


  final List<MealPreview> _favorites = [];


  Meal? get randomMeal => _randomMeal;
  List<Category> get categories => _categories;
  List<MealPreview> get featuredMeals => _featuredMeals;
  bool get homeLoading => _homeLoading;
  String? get homeError => _homeError;
  List<MealPreview> get categoryMeals => _categoryMeals;
  String get selectedCategory => _selectedCategory;
  bool get categoryLoading => _categoryLoading;
  List<MealPreview> get searchResults => _searchResults;
  bool get searchLoading => _searchLoading;
  String get searchQuery => _searchQuery;
  Meal? get selectedMeal => _selectedMeal;
  bool get detailLoading => _detailLoading;
  List<MealPreview> get favorites => _favorites;


  Future<void> loadHomeData() async {
    if (_homeLoading) return;
    _homeLoading = true;
    _homeError = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _service.getRandomMeal(),
        _service.getCategories(),
        _service.getMealsByFirstLetter('b'),
      ]);

      _randomMeal = results[0] as Meal?;
      _categories = results[1] as List<Category>;
      final meals = results[2] as List<MealPreview>;
      _featuredMeals = meals.take(10).toList();

      if (_categories.isNotEmpty) {
        _selectedCategory = _categories[0].name;
        await loadMealsByCategory(_categories[0].name, silent: true);
      }
    } catch (e) {
      _homeError = 'Failed to load data. Please check your connection.';
    }

    _homeLoading = false;
    notifyListeners();
  }

  Future<void> loadMealsByCategory(String category, {bool silent = false}) async {
    _selectedCategory = category;
    if (!silent) {
      _categoryLoading = true;
      notifyListeners();
    }

    _categoryMeals = await _service.getMealsByCategory(category);

    _categoryLoading = false;
    notifyListeners();
  }

  
  Future<void> searchMeals(String query) async {
    _searchQuery = query;
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _searchLoading = true;
    notifyListeners();

    _searchResults = await _service.searchMeals(query);
    _searchLoading = false;
    notifyListeners();
  }

 
  Future<void> loadMealDetail(String id) async {
    _detailLoading = true;
    _selectedMeal = null;
    notifyListeners();

    _selectedMeal = await _service.getMealById(id);
    _detailLoading = false;
    notifyListeners();
  }


  Future<void> refreshRandomMeal() async {
    _randomMeal = await _service.getRandomMeal();
    notifyListeners();
  }


  bool isFavorite(String id) => _favorites.any((m) => m.id == id);

  void toggleFavorite(MealPreview meal) {
    if (isFavorite(meal.id)) {
      _favorites.removeWhere((m) => m.id == meal.id);
    } else {
      _favorites.add(meal);
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    _searchQuery = '';
    notifyListeners();
  }
}
