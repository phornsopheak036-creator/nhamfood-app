import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../widgets/shimmer_widgets.dart';
import '../utils/constants.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MealProvider>();
      if (provider.categories.isEmpty) {
        provider.loadHomeData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, isDark),
          SliverToBoxAdapter(
            child: Consumer<MealProvider>(
              builder: (context, provider, _) {
                if (provider.homeLoading) {
                  return _buildLoadingState();
                }
                if (provider.homeError != null) {
                  return _buildErrorState(provider);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (provider.randomMeal != null)
                      _buildHeroMeal(context, provider.randomMeal!, isDark),
                    _buildSectionTitle(context, ' Trending Now'),
                    _buildFeaturedMeals(context, provider),
                    _buildSectionTitle(context, ' Browse by Category'),
                    _buildCategoryChips(context, provider),
                    _buildCategoryMeals(context, provider),
                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    final themeProvider = context.watch<ThemeProvider>();

    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: isDark
          ? const Color(0xFF1E1E2E)
          : Colors.white,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('🍽️', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Nham',
                  style: TextStyle(
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
                TextSpan(
                  text: 'Food',
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => themeProvider.toggleTheme(),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              key: ValueKey(isDark),
              color: isDark ? Colors.amber : const Color(0xFF1A1A2E),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeroMeal(BuildContext context, Meal meal, bool isDark) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, meal.id, meal.name, meal.thumbnail, isHero: true),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B35).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'hero_meal',
                child: CachedNetworkImage(
                  imageUrl: meal.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                      SizedBox(width: 4),
                      Text(
                        'Today\'s Pick',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () => context.read<MealProvider>().refreshRandomMeal(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _chip(meal.category, Icons.category_outlined),
                        const SizedBox(width: 8),
                        _chip(meal.area, Icons.place_outlined),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 11),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildFeaturedMeals(BuildContext context, MealProvider provider) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: provider.featuredMeals.length,
        itemBuilder: (context, index) {
          final meal = provider.featuredMeals[index];
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: MealCard(
              meal: meal,
              onTap: () => _navigateToDetail(context, meal.id, meal.name, meal.thumbnail),
              isFavorite: provider.isFavorite(meal.id),
              onFavorite: () => provider.toggleFavorite(meal),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context, MealProvider provider) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: provider.categories.length,
        itemBuilder: (context, index) {
          final cat = provider.categories[index];
          final isSelected = provider.selectedCategory == cat.name;
          final emoji = AppConstants.categoryEmojis[cat.name] ?? '';

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => provider.loadMealsByCategory(cat.name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFF6B35)
                      : Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFFF6B35).withOpacity(0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  '$emoji ${cat.name}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryMeals(BuildContext context, MealProvider provider) {
    if (provider.categoryLoading) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: List.generate(3, (_) => const ShimmerListCard()),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: provider.categoryMeals.take(5).map((meal) {
          return MealListCard(
            meal: meal,
            onTap: () => _navigateToDetail(context, meal.id, meal.name, meal.thumbnail),
            isFavorite: provider.isFavorite(meal.id),
            onFavorite: () => provider.toggleFavorite(meal),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ShimmerCard(height: 220, borderRadius: 24),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 28, 20, 14),
          child: ShimmerCard(height: 24, width: 150, borderRadius: 8),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 4,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.only(right: 14),
              child: ShimmerMealCard(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(MealProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 16),
            Text(
              provider.homeError ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: provider.loadHomeData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String id, String name, String thumbnail, {bool isHero = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          mealId: id,
          mealName: name,
          thumbnail: thumbnail,
          heroTag: isHero ? 'hero_meal' : 'meal_$id',
        ),
      ),
    );
  }
}
