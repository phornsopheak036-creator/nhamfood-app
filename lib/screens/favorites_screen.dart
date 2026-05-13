import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Consumer<MealProvider>(
          builder: (context, provider, _) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favorites',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          '${provider.favorites.length} saved meals',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? const Color(0xFF6B6B8A)
                                : const Color(0xFF9E9E9E),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                if (provider.favorites.isEmpty)
                  SliverFillRemaining(
                    child: _buildEmptyState(context),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final meal = provider.favorites[index];
                          return MealCard(
                            meal: meal,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailScreen(
                                    mealId: meal.id,
                                    mealName: meal.name,
                                    thumbnail: meal.thumbnail,
                                    heroTag: 'fav_meal_${meal.id}',
                                  ),
                                ),
                              );
                            },
                            isFavorite: true,
                            onFavorite: () => provider.toggleFavorite(meal),
                            width: double.infinity,
                          );
                        },
                        childCount: provider.favorites.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.8,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Text('❤️', style: TextStyle(fontSize: 50)),
          ),
          const SizedBox(height: 20),
          Text(
            'No favorites yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Tap the heart on any meal\nto save it here',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], height: 1.5),
          ),
        ],
      ),
    );
  }
}
