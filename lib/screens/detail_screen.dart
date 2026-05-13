import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/meal_provider.dart';
import '../models/meal.dart';
import '../utils/constants.dart';

class DetailScreen extends StatefulWidget {
  final String mealId;
  final String mealName;
  final String thumbnail;
  final String heroTag;

  const DetailScreen({
    super.key,
    required this.mealId,
    required this.mealName,
    required this.thumbnail,
    required this.heroTag,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(() {
      final show = _scrollController.offset > 200;
      if (show != _showTitle) setState(() => _showTitle = show);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MealProvider>().loadMealDetail(widget.mealId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Consumer<MealProvider>(
        builder: (context, provider, _) {
          if (provider.detailLoading) {
            return _buildLoadingState(context);
          }
          if (provider.selectedMeal == null) {
            return _buildErrorState(context);
          }
          return _buildContent(
              context, provider.selectedMeal!, isDark, provider);
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, Meal meal, bool isDark, MealProvider provider) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: isDark ? const Color(0xFF1E1E2E) : Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF1A1A2E),
                size: 18,
              ),
            ),
          ),
          actions: [
            Consumer<MealProvider>(
              builder: (context, prov, _) {
                final preview = MealPreview(
                  id: meal.id,
                  name: meal.name,
                  thumbnail: meal.thumbnail,
                );
                final isFav = prov.isFavorite(meal.id);
                return GestureDetector(
                  onTap: () => prov.toggleFavorite(preview),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? const Color(0xFFFF6B35) : Colors.grey,
                      size: 20,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 4),
          ],
          title: AnimatedOpacity(
            opacity: _showTitle ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Text(
              meal.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: widget.heroTag,
              child: CachedNetworkImage(
                imageUrl: meal.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, meal),
              _buildTabBar(context, isDark),
              _buildTabContent(context, meal),
              if (meal.youtubeUrl != null && meal.youtubeUrl!.isNotEmpty)
                _buildYoutubeButton(meal.youtubeUrl!),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, Meal meal) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meal.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _infoChip(context, '🌍 ${meal.area}', const Color(0xFF2D9CDB)),
              _infoChip(
                  context,
                  '${AppConstants.categoryEmojis[meal.category] ?? '🍽️'} ${meal.category}',
                  const Color(0xFF27AE60)),
              if (meal.tags != null && meal.tags!.isNotEmpty)
                ...meal.tags!.split(',').take(2).map(
                      (tag) => _infoChip(
                          context, '#${tag.trim()}', const Color(0xFFFF6B35)),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A3E) : const Color(0xFFF0EDE8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFFFF6B35),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: isDark ? Colors.grey : const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Ingredients'),
          Tab(text: 'Instructions'),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, Meal meal) {
    return SizedBox(
      height: 420,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildIngredients(context, meal),
          _buildInstructions(context, meal),
        ],
      ),
    );
  }

  Widget _buildIngredients(BuildContext context, Meal meal) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meal.ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = meal.ingredients[index];
        final measure = meal.measures[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Color(0xFFFF6B35),
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ingredient,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (measure.isNotEmpty)
                Text(
                  measure,
                  style: const TextStyle(
                    color: Color(0xFFFF6B35),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInstructions(BuildContext context, Meal meal) {
    final steps = meal.instructions
        .split('\n')
        .where((s) => s.trim().isNotEmpty)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  steps[index].trim(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildYoutubeButton(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_filled, color: Colors.white, size: 24),
            SizedBox(width: 10),
            Text(
              'Watch on YouTube',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: widget.heroTag,
              child: CachedNetworkImage(
                imageUrl: widget.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFF1A1A2E), size: 18),
            ),
          ),
        ),
        const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(color: Color(0xFFFF6B35)),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('', style: TextStyle(fontSize: 60)),
            SizedBox(height: 16),
            Text('Could not load meal details'),
          ],
        ),
      ),
    );
  }
}
