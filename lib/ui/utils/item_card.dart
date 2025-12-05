import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final ColorScheme cs;
  final bool needsInfoChip;
  final int index;
  final double? cardWidth;
  final double? cardHeight;
  final double? containerMargin;

  const ItemCard({
    super.key,
    required this.cs,
    required this.needsInfoChip,
    required this.index,
    this.cardWidth,
    this.cardHeight,
    this.containerMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Image.asset(
                  'assets/images/hotel${index + 1}.jpg',
                  fit: BoxFit.cover,
                  // optional: add a subtle dark overlay so white text is readable
                  // color: Colors.black.withAlpha(10),
                  // colorBlendMode: BlendMode.darken,
                ),
              ),

              // ---------- BOTTOM INFO CARD ----------
              Align(
                alignment: Alignment.bottomCenter,
                // child: Padding(
                // Small padding so the inner “info card” doesn’t touch the outer edges
                // padding: const EdgeInsets.all(2),
                child: Card(
                  color: cs.onPrimary.withValues(alpha: 0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aurora Luxe',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Oregon, United States',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        if (needsInfoChip) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _infoChip(Icons.king_bed_outlined, '4 Rooms'),
                              const SizedBox(width: 12),
                              _infoChip(Icons.bathtub_outlined, '4 Bathrooms'),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
