// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/presentation/controllers/home_controller/house_controller.dart';
import 'package:inn/presentation/shared/house_card.dart';
import 'package:inn/presentation/shared/item_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeHouseControllerProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final housesAsync = ref.watch(houseStreamProvider);
    ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.onPrimary,
      appBar: AppBar(
        toolbarHeight: 0,
        shadowColor: cs.onPrimary,
        backgroundColor: cs.onPrimary,
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
      ),

      body: SafeArea(
        child: ColoredBox(
          color: cs.onSurface.withValues(alpha: 0.05),
          child: RefreshIndicator(
            onRefresh: () async {
              await ref.read(homeHouseControllerProvider.notifier).refresh();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // TOP SECTION
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    child: ColoredBox(
                      color: cs.onPrimary,
                      child: Column(
                        children: [
                          // TOP HEADER
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: cs.onSurface.withValues(
                                        alpha: 0.05,
                                      ),
                                      backgroundImage: AssetImage(
                                        'assets/img_assets/avatar.png',
                                      ),
                                    ),
                                    //   ],
                                    // ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.wb_sunny,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              'SUNNY',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color:
                                                    cs.surfaceContainerHighest,
                                                fontWeight: FontWeight.w400,
                                                decorationThickness: 2.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          'Jay',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                // Settings Icon
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: cs.onSurface.withValues(
                                        alpha: 0.05,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.black12,
                                      //     blurRadius: 10,
                                      //     offset: Offset(0, 4),
                                      //   ),
                                      // ],
                                    ),
                                    child: const Icon(Icons.settings, size: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // SEARCH BAR
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                readOnly: true,
                                onTap: () {
                                  context.pushNamed('search');
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search Destination',
                                  hintStyle: TextStyle(
                                    color: cs.onSurface.withAlpha(100),
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: cs.onSurface,
                                  ),
                                  filled: true,
                                  fillColor: cs.onSurface.withValues(
                                    alpha: 0.05,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: TextStyle(fontSize: 16),
                                cursorHeight: 20,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),

                  // BOTTOM SECTION
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 100),
                    child: Column(
                      children: [
                        // Recently Viewed
                        _sectionHeader('Recently Viewed', () {
                          context.pushNamed('app_colors');
                        }),
                        const SizedBox(height: 16),
                        _horizontalHouseList(
                          housesAsync: housesAsync,
                          tagPrefix: 'recent',
                          useItemCard: true,
                          limit: 5,
                          reverse: false,
                        ),

                        const SizedBox(height: 32),

                        // Popular Hotels
                        _sectionHeader('Popular Hotels', () {
                          context.pushNamed('explore');
                        }),
                        const SizedBox(height: 16),
                        _popularHotelsGrid(
                          housesAsync: housesAsync,
                          tagPrefix: 'popular',
                          limit: 5,
                          reverse: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, VoidCallback onTap) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(7)),
          onPressed: onTap,
          child: Row(
            children: [
              Text(
                'See all',
                style: TextStyle(color: cs.primary, fontSize: 14),
              ),
              Icon(Icons.keyboard_arrow_right, size: 16, color: cs.primary),
            ],
          ),
        ),
      ],
    );
  }

  // Renamed from _recentlyViewedList to be more generic since it handles both
  Widget _horizontalHouseList({
    required AsyncValue<List<HouseModel>> housesAsync,
    required String tagPrefix,
    required bool useItemCard,
    required int limit,
    required bool reverse,
  }) {
    // ColorScheme cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 260,
      child: housesAsync.when(
        data: (allHouses) {
          if (allHouses.isEmpty) {
            return const Center(child: Text("No houses found"));
          }

          // Apply slicing logic:
          // 1. Reverse if needed
          Iterable<HouseModel> processed = reverse
              ? allHouses.reversed
              : allHouses;
          // 2. Take limit
          final displayHouses = processed.take(limit).toList();

          if (displayHouses.isEmpty) {
            return const Center(child: Text("No houses to display"));
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: displayHouses.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final house = displayHouses[index];
              if (useItemCard) {
                return ItemCard(
                  house: house,
                  tagPrefix: tagPrefix,
                  index: index,
                  cardWidth: 280,
                  // cardHeight: 250,
                );
              } else {
                return HouseCard(house: house, tagPrefix: tagPrefix);
              }
            },
          );
        },
        error: (err, stack) => Center(child: Text("Error: $err")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _popularHotelsGrid({
    required AsyncValue<List<HouseModel>> housesAsync,
    required String tagPrefix,
    required int limit,
    required bool reverse,
  }) {
    // ColorScheme cs = Theme.of(context).colorScheme;

    return housesAsync.when(
      data: (allHouses) {
        if (allHouses.isEmpty) {
          return const Center(child: Text("No houses found"));
        }

        // Apply slicing logic:
        Iterable<HouseModel> processed = reverse
            ? allHouses.reversed
            : allHouses;
        final displayHouses = processed.take(limit).toList();

        if (displayHouses.isEmpty) {
          return const Center(child: Text("No houses to display"));
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            // Adjust aspect ratio to prevent overflow
            // Height of card ~ 230-250px (140 img + padding + text)
            // Width varies by screen, e.g. (360 - 40 - 16) / 2 = 152
            // Ratio ~ 152 / 240 = 0.63
            childAspectRatio: 0.68,
          ),
          itemCount: displayHouses.length,
          itemBuilder: (context, index) {
            final house = displayHouses[index];
            return HouseCard(house: house, tagPrefix: tagPrefix);
          },
        );
      },
      error: (err, stack) => Center(child: Text("Error: $err")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
