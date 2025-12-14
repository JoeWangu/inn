// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExploreHouseController)
const exploreHouseControllerProvider = ExploreHouseControllerProvider._();

final class ExploreHouseControllerProvider
    extends $AsyncNotifierProvider<ExploreHouseController, bool> {
  const ExploreHouseControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exploreHouseControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exploreHouseControllerHash();

  @$internal
  @override
  ExploreHouseController create() => ExploreHouseController();
}

String _$exploreHouseControllerHash() =>
    r'9e8dd3f4b49d9e796ea16a2e52423183df252a76';

abstract class _$ExploreHouseController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
