// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Favorites)
const favoritesProvider = FavoritesProvider._();

final class FavoritesProvider
    extends $StreamNotifierProvider<Favorites, List<int>> {
  const FavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesHash();

  @$internal
  @override
  Favorites create() => Favorites();
}

String _$favoritesHash() => r'6f7a25891ba04b1d5dba6ae06d1768f32c379976';

abstract class _$Favorites extends $StreamNotifier<List<int>> {
  Stream<List<int>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<int>>, List<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<int>>, List<int>>,
              AsyncValue<List<int>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(favoriteHouses)
const favoriteHousesProvider = FavoriteHousesProvider._();

final class FavoriteHousesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HouseModel>>,
          List<HouseModel>,
          Stream<List<HouseModel>>
        >
    with $FutureModifier<List<HouseModel>>, $StreamProvider<List<HouseModel>> {
  const FavoriteHousesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteHousesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteHousesHash();

  @$internal
  @override
  $StreamProviderElement<List<HouseModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HouseModel>> create(Ref ref) {
    return favoriteHouses(ref);
  }
}

String _$favoriteHousesHash() => r'b8197b5c9b742d969435b00c8912bb3c022f3526';
