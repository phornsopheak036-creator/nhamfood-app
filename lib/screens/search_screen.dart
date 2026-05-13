import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_card.dart';
import '../widgets/shimmer_widgets.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _popularSearches = [
    'Chicken', 'Pasta', 'Pizza', 'Sushi', 'Burger',
    'Tacos', 'Curry', 'Soup', 'Salad', 'Steak',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isDark),
            _buildSearchBar(context, isDark),
            Expanded(
              child: Consumer<MealProvider>(
                builder: (context, provider, _) {
                  if (provider.searchQuery.isEmpty) {
                    return _buildEmptyState(context, provider);
                  }
                  if (provider.searchLoading) {
                    return _buildLoadingState();
                  }
                  if (provider.searchResults.isEmpty) {
                    return _buildNoResults(context);
                  }
                  return _buildResults(context, provider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          ),
          Text(
            'Find your perfect meal',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? const Color(0xFF6B6B8A) : const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: (value) {
          context.read<MealProvider>().searchMeals(value);
        },
        decoration: InputDecoration(
          hintText: 'Search for meals, ingredients...',
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFFFF6B35)),
          suffixIcon: _controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _controller.clear();
                    context.read<MealProvider>().clearSearch();
                  },
                  child: const Icon(Icons.close_rounded, color: Colors.grey),
                )
              : null,
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) =>
            context.read<MealProvider>().searchMeals(value),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, MealProvider provider) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            '🔥 Popular Searches',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _popularSearches.map((term) {
              return GestureDetector(
                onTap: () {
                  _controller.text = term;
                  provider.searchMeals(term);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E1E2E)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    term,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '🍴',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Search for any meal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Type a dish name, ingredient,\nor cuisine to get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? const Color(0xFF6B6B8A)
                        : const Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (_, __) => const ShimmerListCard(),
    );
  }

  Widget _buildNoResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🤔', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          Text(
            'No meals found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with a different keyword',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context, MealProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(
            children: [
              Text(
                '${provider.searchResults.length} Results',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFF6B35),
                ),
              ),
              Text(
                ' for "${provider.searchQuery}"',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              final meal = provider.searchResults[index];
              return MealListCard(
                meal: meal,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(
                        mealId: meal.id,
                        mealName: meal.name,
                        thumbnail: meal.thumbnail,
                        heroTag: 'search_meal_${meal.id}',
                      ),
                    ),
                  );
                },
                isFavorite: provider.isFavorite(meal.id),
                onFavorite: () => provider.toggleFavorite(meal),
              );
            },
          ),
        ),
      ],
    );
  }
}
