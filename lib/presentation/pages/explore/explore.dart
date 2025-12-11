import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/home_controller/house_controller.dart';
// import 'package:inn/presentation/shared/house_card.dart'; // Reuse the card or make a new one

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final housesAsync = ref.watch(houseStreamProvider);

    // Watch logic state (to show loading spinner at bottom)
    final exploreState = ref.watch(exploreHouseControllerProvider);

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
              return const Center(child: Text("No items yet"));
            }

            return ListView.builder(
              itemCount: houses.length + 1, // +1 for the loader at the bottom
              itemBuilder: (context, index) {
                // Loader at the bottom
                if (index == houses.length) {
                  return exploreState.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }

                final house = houses[index];
                // You can create a vertical version of the card here
                return ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.network(
                      house.imageDetail.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(house.title),
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
}
