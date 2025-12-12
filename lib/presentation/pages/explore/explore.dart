import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/explore_contoller/explore_controller.dart';
import 'package:inn/presentation/controllers/home_controller/house_controller.dart';
// import 'package:inn/presentation/shared/house_card.dart'; // Reuse the card or make a new one

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Data Stream (The List)
    final housesAsync = ref.watch(houseStreamProvider);

    // Controller State (Pagination Status)
    // Value is 'hasMore' (true/false)
    final paginationState = ref.watch(exploreHouseControllerProvider);

    // Watch logic state (to show loading spinner at bottom)
    // final exploreState = ref.watch(exploreHouseControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Explore")),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // Check if we scrolled to bottom (threshold 200px)
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent - 200) {
            // Trigger load next page
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
              itemCount: houses.length + 1, // +1 for the loader at the bottom
              itemBuilder: (context, index) {
                // === FOOTER LOGIC ===
                if (index == houses.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(child: _buildFooter(paginationState)),
                  );
                }

                // Loader at the bottom
                // if (index == houses.length) {
                //   return exploreState.isLoading
                //       ? const Padding(
                //           padding: EdgeInsets.all(20.0),
                //           child: Center(child: CircularProgressIndicator()),
                //         )
                //       : const SizedBox.shrink();
                // }

                final house = houses[index];
                final tag = 'explore_${house.id}';
                // You can create a vertical version of the card here
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
                        house.imageDetail.image ?? '',
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
              },
            );
          },
          error: (e, s) => Center(child: Text("$e")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildFooter(AsyncValue<bool> state) {
    // 1. If Loading -> Show Spinner
    if (state.isLoading) {
      return const CircularProgressIndicator();
    }

    // 2. If Error -> Show Retry button (Optional)
    if (state.hasError) {
      return const Text("Error loading more. Scroll up and down to retry.");
    }

    // 3. If hasMore is FALSE -> Show "No more items"
    if (state.value == false) {
      return const Text(
        "You've reached the end! 🎉",
        style: TextStyle(color: Colors.grey),
      );
    }

    // 4. Default (Idle, hasMore=true) -> Show nothing
    // We wait for the user to scroll to trigger the loader
    return const SizedBox.shrink();
  }
}
