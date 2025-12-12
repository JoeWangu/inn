// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchHouseController)
const searchHouseControllerProvider = SearchHouseControllerProvider._();

final class SearchHouseControllerProvider
    extends $AsyncNotifierProvider<SearchHouseController, List<HouseModel>> {
  const SearchHouseControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchHouseControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHouseControllerHash();

  @$internal
  @override
  SearchHouseController create() => SearchHouseController();
}

String _$searchHouseControllerHash() =>
    r'0a6d874a0b78b5d73a617791be00bd3c9c480c71';

abstract class _$SearchHouseController
    extends $AsyncNotifier<List<HouseModel>> {
  FutureOr<List<HouseModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<HouseModel>>, List<HouseModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HouseModel>>, List<HouseModel>>,
              AsyncValue<List<HouseModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
