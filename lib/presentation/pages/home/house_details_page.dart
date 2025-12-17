import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/data/models/rating_model.dart';
import 'package:inn/presentation/controllers/ratings_controller/ratings_controller.dart';
import 'package:inn/core/errors/error_handler.dart';

class HouseDetailsPage extends ConsumerWidget {
  final HouseModel house;
  final String heroTag;

  const HouseDetailsPage({
    super.key,
    required this.house,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final ratingsAsync = ref.watch(ratingsControllerProvider);

    RatingModel? userRating;
    ratingsAsync.whenData((ratings) {
      try {
        userRating = ratings.firstWhere((r) => r.rental == house.id);
      } catch (e) {
        userRating = null;
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // APP BAR IMAGE
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: colorScheme.surface,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: heroTag,
                        child: CachedNetworkImage(
                          imageUrl: house.imageDetail?.image ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: colorScheme.surfaceContainerHighest,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.pushNamed('photo-gallery', extra: house.id);
                          },
                          icon: const Icon(Icons.grid_view, size: 18),
                          label: const Text('View Photos'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.surface,
                            foregroundColor: colorScheme.onSurface,
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // CONTENT
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  house.title ?? '',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                // OVERALL RATING DISPLAY
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      house.avgRating.toStringAsFixed(1),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      " (Overall)",
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "KES ${house.price.toStringAsFixed(0)}",
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            house.neighborhood?.name ??
                                house.city?.name ??
                                "Unknown Location",
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tags (Category, Units)
                      Row(
                        children: [
                          _buildTag(
                            house.category ?? '',
                            colorScheme.primaryContainer,
                            colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 10),
                          _buildTag(
                            "${house.totalUnits} Units",
                            colorScheme.surfaceContainerHighest,
                            colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // RATING SECTION
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.secondaryContainer,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  userRating == null
                                      ? "Rate this place"
                                      : "Your Rating",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                if (userRating != null)
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: colorScheme.error,
                                    ),
                                    onPressed: () async {
                                      try {
                                        await ref
                                            .read(
                                              ratingsControllerProvider
                                                  .notifier,
                                            )
                                            .deleteRating(userRating!.id);
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Rating removed'),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getReadableError(e),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (userRating != null) ...[
                              Text(
                                userRating!.ratingReason ?? '',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                            RatingBar.builder(
                              initialRating: userRating?.stars.toDouble() ?? 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 32,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {
                                _showRatingDialog(
                                  context,
                                  ref,
                                  rating.toInt(),
                                  userRating,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Host Section
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: colorScheme.primary.withValues(
                                alpha: 0.2,
                              ),
                              child: Text(
                                house.authorDetail.username?[0].toUpperCase() ??
                                    'Unknown',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Posted by ${house.authorDetail.username}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Posted: ${house.datePosted.toString().split(' ')[0]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Description
                      Text(
                        "About this place",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        house.description ?? "No description provided.",
                        style: TextStyle(
                          height: 1.5,
                          color: colorScheme.onSurface,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // BOTTOM BUTTON (Floating)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Call or Booking logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Contact Host",
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }

  void _showRatingDialog(
    BuildContext context,
    WidgetRef ref,
    int stars,
    RatingModel? currentRating,
  ) {
    final TextEditingController reasonController = TextEditingController(
      text: currentRating?.ratingReason ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          currentRating == null ? "Rate this Place" : "Update Rating",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < stars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: "Reason (Optional)",
                border: OutlineInputBorder(),
                hintText: "What did you like or dislike?",
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              try {
                if (currentRating == null) {
                  // Add
                  await ref
                      .read(ratingsControllerProvider.notifier)
                      .addRating(
                        houseId: house.id,
                        stars: stars,
                        reason: reasonController.text,
                      );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rating added!')),
                    );
                  }
                } else {
                  // Update
                  await ref
                      .read(ratingsControllerProvider.notifier)
                      .updateRating(
                        ratingId: currentRating.id,
                        houseId: house.id,
                        stars: stars,
                        reason: reasonController.text,
                      );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rating updated!')),
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(getReadableError(e))));
                }
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
