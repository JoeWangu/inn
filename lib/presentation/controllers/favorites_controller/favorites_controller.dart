import 'package:inn/data/models/house_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/domain/repositories/favorites_repository.dart';

part 'favorites_controller.g.dart';

@Riverpod(keepAlive: true)
class Favorites extends _$Favorites {
  @override
  Stream<List<int>> build() {
    final repo = ref.watch(favoritesRepositoryProvider);
    // Determine sync on startup?
    // We can fire and forget sync here
    repo.syncFavorites();

    return repo.watchFavoriteIds();
  }

  Future<void> toggleFavorite(HouseModel house) async {
    final repo = ref.read(favoritesRepositoryProvider);
    await repo.toggleFavorite(house);
  }
}

// Separate provider for the list of favorite objects (for the Favorites Page)
@Riverpod(keepAlive: true)
Stream<List<HouseModel>> favoriteHouses(Ref ref) {
  final repo = ref.watch(favoritesRepositoryProvider);
  return repo.watchFavorites();
}
