// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/presentation/controllers/home_controller/house_controller.dart';
import 'package:inn/presentation/shared/house_card.dart';
import 'package:inn/presentation/shared/item_card.dart';
import 'package:inn/core/errors/error_handler.dart';
import 'package:inn/presentation/controllers/profile_controller.dart';
// import 'package:inn/ad_helper.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // Future<InitializationStatus> _initGoogleMobileAds() async {
  //   return MobileAds.instance.initialize();
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeHouseControllerProvider);
    });
    // if (Platform.isAndroid || Platform.isIOS) {
    //   _initGoogleMobileAds();
    // }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'GOOD MORNING';
    if (hour < 17) return 'GOOD AFTERNOON';
    return 'GOOD EVENING';
  }

  @override
  Widget build(BuildContext context) {
    final housesAsync = ref.watch(houseStreamProvider);
    final profileAsync = ref.watch(profileControllerProvider);
    ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 0,
      //   scrolledUnderElevation: 0.0,
      //   surfaceTintColor: Colors.transparent,
      // ),
      body: SafeArea(
        child: ColoredBox(
          color: cs.onSurface.withValues(alpha: 0.05),
          child: RefreshIndicator(
            onRefresh: () async {
              await ref.read(homeHouseControllerProvider.notifier).refresh();
              await ref.read(profileControllerProvider.notifier).refresh();
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
                      color: cs.surface,
                      child: Column(
                        children: [
                          // TOP HEADER
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    profileAsync.when(
                                      data: (profile) => CircleAvatar(
                                        radius: 24,
                                        backgroundColor: cs.onSurface
                                            .withValues(alpha: 0.05),
                                        backgroundImage:
                                            profile?.profilePicture != null
                                            ? NetworkImage(
                                                    profile!.profilePicture!,
                                                  )
                                                  as ImageProvider
                                            : const AssetImage(
                                                'assets/img_assets/avatar.png',
                                              ),
                                      ),
                                      loading: () => CircleAvatar(
                                        radius: 24,
                                        backgroundColor: cs.onSurface
                                            .withValues(alpha: 0.05),
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      error: (e, s) => CircleAvatar(
                                        radius: 24,
                                        backgroundColor: cs.onSurface
                                            .withValues(alpha: 0.05),
                                        backgroundImage: const AssetImage(
                                          'assets/img_assets/avatar.png',
                                        ),
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
                                            // Icon(
                                            //   Icons.wb_sunny,
                                            //   color: Colors.amber,
                                            //   size: 18,
                                            // ),
                                            // const SizedBox(width: 6),
                                            Text(
                                              _getGreeting(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    color: cs.onSurface,
                                                    fontWeight: FontWeight.w400,
                                                    decorationThickness: 2.0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        profileAsync.when(
                                          data: (profile) {
                                            final name =
                                                profile?.username ??
                                                profile?.firstName ??
                                                'User';
                                            return Text(
                                              name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            );
                                          },
                                          loading: () => const SizedBox(
                                            height: 20,
                                            width: 50,
                                            child: LinearProgressIndicator(),
                                          ),
                                          error: (e, s) => Text(
                                            'User',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
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
                                  onTap: () {
                                    context.pushNamed('settings');
                                  },
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
                          // context.pushNamed('app_colors');
                        }),
                        const SizedBox(height: 16),
                        _horizontalHouseList(
                          housesAsync: housesAsync,
                          tagPrefix: 'recent',
                          useItemCard: true,
                          limit: 5,
                          reverse: false,
                          cs: cs,
                        ),

                        const SizedBox(height: 32),

                        // Popular Hotels
                        _sectionHeader('Popular Hotels', () {
                          // context.pushNamed('explore');
                        }),
                        const SizedBox(height: 16),
                        _popularHotelsGrid(
                          housesAsync: housesAsync,
                          tagPrefix: 'popular',
                          limit: 5,
                          reverse: true,
                          cs: cs,
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
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(7)),
          onPressed: onTap,
          child: Row(
            children: [
              Text(
                'See all',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: cs.primary),
              ),
              Icon(Icons.keyboard_arrow_right, size: 16, color: cs.primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _horizontalHouseList({
    required AsyncValue<List<HouseModel>> housesAsync,
    required String tagPrefix,
    required bool useItemCard,
    required int limit,
    required bool reverse,
    required ColorScheme cs,
  }) {
    return SizedBox(
      height: 260,
      child: housesAsync.when(
        data: (allHouses) {
          if (allHouses.isEmpty) {
            return const Center(child: Text("No houses found"));
          }

          Iterable<HouseModel> processed = reverse
              ? allHouses.reversed
              : allHouses;
          final displayHouses = processed.take(limit).toList();

          if (displayHouses.isEmpty) {
            return const Center(child: Text("No houses to display"));
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
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
                return HouseCard(house: house, tagPrefix: tagPrefix, cs: cs);
              }
            },
          );
        },
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              getReadableError(err),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _popularHotelsGrid({
    required AsyncValue<List<HouseModel>> housesAsync,
    required String tagPrefix,
    required int limit,
    required bool reverse,
    required ColorScheme cs,
  }) {
    return housesAsync.when(
      data: (allHouses) {
        if (allHouses.isEmpty) {
          return const Center(child: Text("No houses found"));
        }

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
            childAspectRatio: 0.68,
          ),
          itemCount: displayHouses.length,
          itemBuilder: (context, index) {
            final house = displayHouses[index];
            return HouseCard(house: house, tagPrefix: tagPrefix, cs: cs);
          },
        );
      },
      error: (err, stack) => Center(child: Text("Error: $err")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
