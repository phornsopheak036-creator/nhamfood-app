import '../models/food_model.dart';

class FoodService {

  static const String_baseUrl = 'https://www.themealdb.com/api/json/v1/1';

 
  static List<Map<String, dynamic>> khmerFoodData = [
    {
      'id': 1,
      'name': 'Amok Trey',
      'description': 'Amok Trey is Cambodia\'s national dish — a fragrant fish curry steamed in banana leaves with coconut milk and kroeung paste. It has a rich, creamy texture and mild spice.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Cambodian_fish_amok.jpg/640px-Cambodian_fish_amok.jpg',
      'category': 'Main Dish',
      'origin': 'Cambodia',
      'cook_time': '45 mins',
      'ingredients': ['Fish fillet', 'Coconut milk', 'Kroeung paste', 'Banana leaves', 'Egg', 'Fish sauce', 'Kaffir lime leaves', 'Lemongrass'],
      'recipe': '1. Blend kroeung paste with coconut milk.\n2. Mix in fish and egg.\n3. Pour into banana leaf cups.\n4. Steam for 30 minutes.\n5. Top with coconut cream and serve.',
    },
    {
      'id': 2,
      'name': 'Bai Sach Chrouk',
      'description': 'Grilled pork over broken rice, served with pickled vegetables and a light broth. A beloved Cambodian breakfast staple enjoyed every morning.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Bai_Sach_Chrouk.jpg/640px-Bai_Sach_Chrouk.jpg',
      'category': 'Breakfast',
      'origin': 'Phnom Penh',
      'cook_time': '30 mins',
      'ingredients': ['Pork slices', 'Broken rice', 'Coconut milk', 'Garlic', 'Pickled vegetables', 'Soy sauce', 'Ginger broth'],
      'recipe': '1. Marinate pork in coconut milk and garlic overnight.\n2. Grill pork over charcoal.\n3. Serve on broken rice.\n4. Add pickled veggies and pour hot broth on the side.',
    },
    {
      'id': 3,
      'name': 'Nom Banh Chok',
      'description': 'Khmer noodles topped with a fresh green fish-based curry sauce, served with raw vegetables and banana blossom. Known as "Khmer noodles" and eaten for breakfast.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Nom_Banh_Chok.jpg/640px-Nom_Banh_Chok.jpg',
      'category': 'Breakfast',
      'origin': 'Cambodia',
      'cook_time': '1 hour',
      'ingredients': ['Rice noodles', 'Fish', 'Lemongrass', 'Turmeric', 'Kaffir lime', 'Coconut milk', 'Bean sprouts', 'Banana blossom'],
      'recipe': '1. Pound lemongrass, turmeric and galangal into a paste.\n2. Cook fish in water and shred it.\n3. Make green curry sauce with the paste and coconut milk.\n4. Serve over fresh rice noodles.\n5. Top with fresh herbs and vegetables.',
    },
    {
      'id': 4,
      'name': 'Samlor Korko',
      'description': 'A hearty Cambodian soup made with prahok (fermented fish paste), vegetables, and pork. Often called "stir-the-pot soup" due to its diverse mix of ingredients.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Samlor_korko.jpg/640px-Samlor_korko.jpg',
      'category': 'Soup',
      'origin': 'Cambodia',
      'cook_time': '1 hour',
      'ingredients': ['Pork ribs', 'Prahok', 'Green papaya', 'Eggplant', 'Kroeung paste', 'Long beans', 'Banana flower'],
      'recipe': '1. Boil pork ribs to make broth.\n2. Fry kroeung paste with prahok.\n3. Add vegetables and cook until tender.\n4. Combine everything and simmer.\n5. Garnish with fresh herbs.',
    },
    {
      'id': 5,
      'name': 'Loc Lac',
      'description': 'Stir-fried diced beef served on a bed of lettuce with tomatoes and a tangy Kampot pepper sauce. Often served with fried egg and rice.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Loc_lac.jpg/640px-Loc_lac.jpg',
      'category': 'Main Dish',
      'origin': 'Cambodia',
      'cook_time': '20 mins',
      'ingredients': ['Beef cubes', 'Kampot pepper', 'Oyster sauce', 'Soy sauce', 'Lettuce', 'Tomato', 'Lime juice', 'Fried egg'],
      'recipe': '1. Marinate beef in soy sauce and oyster sauce.\n2. Stir-fry on high heat until caramelized.\n3. Serve on lettuce leaves with sliced tomatoes.\n4. Add fried egg on top.\n5. Squeeze lime and black pepper sauce over everything.',
    },
    {
      'id': 6,
      'name': 'Kuy Teav',
      'description': 'A Cambodian noodle soup with clear pork or beef broth, rice vermicelli, and various toppings. A popular street food enjoyed at breakfast.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Kuy_teav.jpg/640px-Kuy_teav.jpg',
      'category': 'Noodle',
      'origin': 'Phnom Penh',
      'cook_time': '2 hours',
      'ingredients': ['Rice vermicelli', 'Pork bones', 'Bean sprouts', 'Garlic', 'Shallots', 'Fish sauce', 'Spring onion', 'Dried shrimp'],
      'recipe': '1. Simmer pork bones for 2 hours to make broth.\n2. Season with fish sauce and sugar.\n3. Cook rice noodles separately.\n4. Place noodles in bowl and pour hot broth.\n5. Top with bean sprouts, herbs and crispy garlic.',
    },
    {
      'id': 7,
      'name': 'Samlor Machu',
      'description': 'A sour Cambodian soup made with tamarind, pineapple, and various proteins. It has a refreshing tangy flavor and is commonly eaten with rice.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Cambodian_sour_soup.jpg/640px-Cambodian_sour_soup.jpg',
      'category': 'Soup',
      'origin': 'Cambodia',
      'cook_time': '40 mins',
      'ingredients': ['Shrimp or fish', 'Tamarind', 'Pineapple', 'Tomato', 'Lemongrass', 'Fish sauce', 'Sugar', 'Mint leaves'],
      'recipe': '1. Make sour base with tamarind water.\n2. Add pineapple chunks and tomatoes.\n3. Add protein and simmer.\n4. Season with fish sauce and sugar.\n5. Finish with fresh mint.',
    },
    {
      'id': 8,
      'name': 'Cha Kroeung Sach Ko',
      'description': 'Lemongrass beef stir-fry, a popular Cambodian dish using kroeung (lemongrass paste). Flavored with kaffir lime leaves and fresh chili.',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Lemongrass_beef.jpg/640px-Lemongrass_beef.jpg',
      'category': 'Main Dish',
      'origin': 'Cambodia',
      'cook_time': '25 mins',
      'ingredients': ['Beef', 'Lemongrass', 'Kaffir lime leaves', 'Galangal', 'Chili', 'Fish sauce', 'Garlic', 'Basil'],
      'recipe': '1. Blend lemongrass paste (kroeung).\n2. Marinate beef with paste and fish sauce.\n3. Stir-fry on high heat.\n4. Add kaffir lime leaves and chili.\n5. Serve with jasmine rice.',
    },
  ];

  Future<List<Food>> getKhmerFoods() async {
    // Simulate network delay like a real API call
    await Future.delayed(const Duration(milliseconds: 800));
    return khmerFoodData.map((json) => Food.fromJson(json)).toList();
  }

  Future<List<Food>> searchFoods(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final all = khmerFoodData.map((json) => Food.fromJson(json)).toList();
    return all.where((food) =>
      food.name.toLowerCase().contains(query.toLowerCase()) ||
      food.category.toLowerCase().contains(query.toLowerCase()) ||
      food.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Future<List<Food>> getFoodsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final all = khmerFoodData.map((json) => Food.fromJson(json)).toList();
    if (category == 'All') return all;
    return all.where((f) => f.category == category).toList();
  }
}
