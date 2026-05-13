import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../models/meal.dart';

class MealCard extends StatelessWidget {
  final MealPreview meal;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavorite;
  final double? width;
  final double? height;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    this.isFavorite = false,
    this.onFavorite,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 180,
        height: height,
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'meal_${meal.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: meal.thumbnail,
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: isDark
                            ? const Color(0xFF2A2A3E)
                            : const Color(0xFFE8E8E8),
                        highlightColor: isDark
                            ? const Color(0xFF3A3A5E)
                            : const Color(0xFFF5F5F5),
                        child: Container(
                          height: 130,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 130,
                        color: isDark
                            ? const Color(0xFF2A2A3E)
                            : const Color(0xFFE8E8E8),
                        child: const Icon(Icons.restaurant, size: 40),
                      ),
                    ),
                  ),
                ),
                if (onFavorite != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? const Color(0xFFFF6B35)
                              : Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                meal.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealListCard extends StatelessWidget {
  final MealPreview meal;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavorite;

  const MealListCard({
    super.key,
    required this.meal,
    required this.onTap,
    this.isFavorite = false,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'meal_list_${meal.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: meal.thumbnail,
                  width: 100,
                  height: 90,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: isDark
                        ? const Color(0xFF2A2A3E)
                        : const Color(0xFFE8E8E8),
                    highlightColor: isDark
                        ? const Color(0xFF3A3A5E)
                        : const Color(0xFFF5F5F5),
                    child: Container(
                      width: 100,
                      height: 90,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 90,
                    color: isDark
                        ? const Color(0xFF2A2A3E)
                        : const Color(0xFFE8E8E8),
                    child: const Icon(Icons.restaurant),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 14,
                          color: Color(0xFFFF6B35),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Popular',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFFF6B35),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (onFavorite != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: onFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? const Color(0xFFFF6B35)
                        : Colors.grey,
                    size: 22,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
