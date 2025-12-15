// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(houseStream)
const houseStreamProvider = HouseStreamProvider._();

final class HouseStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HouseModel>>,
          List<HouseModel>,
          Stream<List<HouseModel>>
        >
    with $FutureModifier<List<HouseModel>>, $StreamProvider<List<HouseModel>> {
  const HouseStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'houseStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$houseStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<HouseModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HouseModel>> create(Ref ref) {
    return houseStream(ref);
  }
}

String _$houseStreamHash() => r'581569d39452cc8012271ff02e08e338e51359e9';

@ProviderFor(HomeHouseController)
const homeHouseControllerProvider = HomeHouseControllerProvider._();

final class HomeHouseControllerProvider
    extends $AsyncNotifierProvider<HomeHouseController, void> {
  const HomeHouseControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeHouseControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeHouseControllerHash();

  @$internal
  @override
  HomeHouseController create() => HomeHouseController();
}

String _$homeHouseControllerHash() =>
    r'f5e112b14a3494ee85bab86918a00b9eb50ef2f1';

abstract class _$HomeHouseController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
