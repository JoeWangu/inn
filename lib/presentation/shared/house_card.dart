import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/data/models/house_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/favorites_controller/favorites_controller.dart';

class HouseCard extends ConsumerWidget {
  final HouseModel house;
  final String tagPrefix;
  final ColorScheme cs;

  const HouseCard({
    super.key,
    required this.house,
    this.tagPrefix = 'home',
    required this.cs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tag = '${tagPrefix}_${house.id}';
    final favoritesAsync = ref.watch(favoritesProvider);
    final isFavorite = favoritesAsync.maybeWhen(
      data: (ids) => ids.contains(house.id),
      orElse: () => false,
    );

    return GestureDetector(
      onTap: () => context.pushNamed(
        'house-details',
        extra: {'house': house, 'tag': tag},
      ),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: house.imageDetail?.image ?? '',
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: cs.surfaceContainerHighest),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await ref
                            .read(favoritesProvider.notifier)
                            .toggleFavorite(house);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to update favorite: Check your connection and try again',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : cs.onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KES ${house.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    house.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    house.neighborhood?.name ??
                        house.city?.name ??
                        "Unknown Location",
                    style: TextStyle(color: cs.onSurface, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
