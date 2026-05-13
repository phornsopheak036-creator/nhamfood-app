import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../services/food_service.dart';

class FoodProvider extends ChangeNotifier {
  final FoodService _service = FoodService();

  List<Food> _foods = [];
  List<Food> _filteredFoods = [];
  bool _isLoading = false;
  String _error = '';
  String _selectedCategory = 'All';

  List<Food> get foods => _foods;
  List<Food> get filteredFoods => _filteredFoods;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get selectedCategory => _selectedCategory;

  List<String> get categories {
    final cats = _foods.map((f) => f.category).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  Future<void> loadFoods() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _foods = await _service.getKhmerFoods();
      _filteredFoods = _foods;
    } catch (e) {
      _error = 'Failed to load foods. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    if (category == 'All') {
      _filteredFoods = _foods;
    } else {
      _filteredFoods = _foods.where((f) => f.category == category).toList();
    }
    notifyListeners();
  }

  Future<List<Food>> searchFoods(String query) async {
    if (query.isEmpty) return _foods;
    return await _service.searchFoods(query);
  }
}
