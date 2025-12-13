import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/data/models/house_model.dart';

class ItemCard extends StatelessWidget {
  final HouseModel house;
  final String tagPrefix;
  final bool needsInfoChip;
  final int index; // kept if needed for fallback styling, but less critical now
  final double? cardWidth;
  final double? cardHeight;
  final double? containerMargin;

  const ItemCard({
    super.key,
    required this.house,
    required this.tagPrefix,
    this.needsInfoChip = true,
    required this.index,
    this.cardWidth,
    this.cardHeight,
    this.containerMargin,
  });

  @override
  Widget build(BuildContext context) {
    // Generate unique Hero tag
    final tag = '${tagPrefix}_${house.id}';
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.pushNamed(
        'house-details',
        extra: {'house': house, 'tag': tag},
      ),
      child: Container(
        margin: EdgeInsets.only(right: containerMargin ?? 0),
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            child: Stack(
              children: [
                // ---------- IMAGE ----------
                Positioned.fill(
                  child: Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: house.imageDetail?.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/img_assets/default.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // ---------- BOTTOM INFO CARD ----------
                Align(
                  alignment: Alignment.bottomCenter,
                  // Small padding so the inner “info card” doesn’t touch the outer edges
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    color: cs.surface.withValues(alpha: 0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            house.title ?? 'Unknown Property',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            house.city?.name ??
                                house.neighborhood?.name ??
                                'Unknown Location',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          if (needsInfoChip) ...[
                            const SizedBox(height: 12),
                            // HouseModel doesn't have bedrooms/bathrooms yet,
                            // showing total units or just category as placeholder
                            Row(
                              children: [
                                _infoChip(
                                  Icons.home_work_outlined,
                                  '${house.totalUnits} Units',
                                ),
                                const SizedBox(width: 8),
                                _infoChip(
                                  Icons.category_outlined,
                                  house.category ?? 'N/A',
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
