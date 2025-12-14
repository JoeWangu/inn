import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inn/presentation/controllers/favorites_controller/favorites_controller.dart';
import 'package:inn/presentation/shared/item_card.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favoritesAsync = ref.watch(favoriteHousesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: true),
      body: favoritesAsync.when(
        data: (houses) {
          if (houses.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: houses.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final house = houses[index];
              return ItemCard(
                house: house,
                tagPrefix: 'fav',
                index: index,
                cardHeight: 300,
                cardWidth: double.infinity,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Error loading favorites")),
      ),
    );
  }
}
