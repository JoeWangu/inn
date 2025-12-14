// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RatingsController)
const ratingsControllerProvider = RatingsControllerProvider._();

final class RatingsControllerProvider
    extends $AsyncNotifierProvider<RatingsController, List<RatingModel>> {
  const RatingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ratingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ratingsControllerHash();

  @$internal
  @override
  RatingsController create() => RatingsController();
}

String _$ratingsControllerHash() => r'720309418c6d687091bf56fd9eecd4009ca229d2';

abstract class _$RatingsController extends $AsyncNotifier<List<RatingModel>> {
  FutureOr<List<RatingModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<RatingModel>>, List<RatingModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RatingModel>>, List<RatingModel>>,
              AsyncValue<List<RatingModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
