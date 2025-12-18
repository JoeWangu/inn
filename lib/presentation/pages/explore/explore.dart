// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/explore_contoller/explore_controller.dart';
import 'package:inn/presentation/controllers/home_controller/house_controller.dart';
import 'package:inn/core/errors/error_handler.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:inn/ad_helper.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  // Future<InitializationStatus> _initGoogleMobileAds() async {
  //   return MobileAds.instance.initialize();
  // }

  // static final _kAdIndex = 2;
  // BannerAd? _ad;

  // int _getDestinationItemIndex(int rawIndex) {
  //   if (rawIndex >= _kAdIndex && _ad != null) {
  //     return rawIndex - 1;
  //   }
  //   return rawIndex;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (Platform.isAndroid || Platform.isIOS) {
  //     _initGoogleMobileAds();
  //     BannerAd(
  //       adUnitId: AdHelper.bannerAdUnitId,
  //       size: AdSize.banner,
  //       request: AdRequest(),
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           setState(() {
  //             _ad = ad as BannerAd;
  //           });
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           // Releases an ad resource when it fails to load
  //           ad.dispose();
  //           debugPrint(
  //             'Ad load failed (code=${error.code} message=${error.message})',
  //           );
  //         },
  //       ),
  //     ).load();
  //   }
  // }

  // @override
  // void dispose() {
  //   _ad?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final housesAsync = ref.watch(houseStreamProvider);

    final paginationState = ref.watch(exploreHouseControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Explore")),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent - 200) {
            ref.read(exploreHouseControllerProvider.notifier).loadNextPage();
          }
          return false;
        },
        child: housesAsync.when(
          data: (houses) {
            if (houses.isEmpty) {
              return const Center(child: Text("No items found"));
            }

            return ListView.builder(
              itemCount: houses.length + 1,
              // itemCount: houses.length + (_ad != null ? 1 : 0),
              itemBuilder: (context, index) {
                // === FOOTER LOGIC ===
                if (index == houses.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(child: _buildFooter(paginationState)),
                  );
                }

                // if (_ad != null && index == _kAdIndex) {
                //   return Container(
                //     width: _ad!.size.width.toDouble(),
                //     height: 72.0,
                //     alignment: Alignment.center,
                //     child: AdWidget(ad: _ad!),
                //   );
                // } else {
                // final house = houses[_getDestinationItemIndex(index)];

                final house = houses[index];
                final tag = 'explore_${house.id}';
                return ListTile(
                  onTap: () => context.pushNamed(
                    'house-details',
                    extra: {'house': house, 'tag': tag},
                  ),
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: Hero(
                      tag: tag,
                      child: Image.network(
                        house.imageDetail?.image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(house.title ?? ''),
                  subtitle: Text(
                    "${house.totalUnits} units • ${house.category}",
                  ),
                  trailing: Text("KES ${house.price}"),
                );
                // }
              },
            );
          },
          error: (e, s) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                getReadableError(e),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildFooter(AsyncValue<bool> state) {
    if (state.isLoading) {
      return const CircularProgressIndicator();
    }

    if (state.hasError) {
      return const Text("Error loading more. Scroll up and down to retry.");
    }

    if (state.value == false) {
      return const Text(
        "You've reached the end! 🎉",
        style: TextStyle(color: Colors.grey),
      );
    }

    return const SizedBox.shrink();
  }
}
