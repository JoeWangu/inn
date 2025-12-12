import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inn/data/models/house_model.dart';

class HouseDetailsPage extends StatelessWidget {
  final HouseModel house;
  final String heroTag;

  const HouseDetailsPage({
    super.key,
    required this.house,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 1. APP BAR IMAGE
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: colorScheme.surface,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: heroTag,
                    child: CachedNetworkImage(
                      imageUrl: house.imageDetail.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),

              // 2. CONTENT
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
                            child: Text(
                              house.title ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
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
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            house.neighborhood?.name ??
                                house.city?.name ??
                                "Unknown Location",
                            style: TextStyle(color: Colors.grey[600]),
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
                            Colors.grey[200]!,
                            Colors.black87,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Host Section
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
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
                                    color: Colors.grey[600],
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
                          color: Colors.grey[800],
                          fontSize: 16,
                        ),
                      ),

                      // Extra padding for bottom button
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. BOTTOM BUTTON (Floating)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
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
                      // Implement Call or Booking logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Contact Host",
                      style: TextStyle(
                        color: Colors.white,
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
}
