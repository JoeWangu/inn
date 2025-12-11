// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(houseRepository)
const houseRepositoryProvider = HouseRepositoryProvider._();

final class HouseRepositoryProvider
    extends
        $FunctionalProvider<HouseRepository, HouseRepository, HouseRepository>
    with $Provider<HouseRepository> {
  const HouseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'houseRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$houseRepositoryHash();

  @$internal
  @override
  $ProviderElement<HouseRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HouseRepository create(Ref ref) {
    return houseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HouseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HouseRepository>(value),
    );
  }
}

String _$houseRepositoryHash() => r'b33e1e0da3e9154a99ee21184b9337af34f6fc75';
