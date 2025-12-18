import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/explore_contoller/explore_controller.dart';
import 'package:inn/presentation/controllers/home_controller/house_controller.dart';
import 'package:inn/core/errors/error_handler.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
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
              itemBuilder: (context, index) {
                // === FOOTER LOGIC ===
                if (index == houses.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(child: _buildFooter(paginationState)),
                  );
                }

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
