// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ratingsRepository)
const ratingsRepositoryProvider = RatingsRepositoryProvider._();

final class RatingsRepositoryProvider
    extends
        $FunctionalProvider<
          RatingsRepository,
          RatingsRepository,
          RatingsRepository
        >
    with $Provider<RatingsRepository> {
  const RatingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ratingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ratingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<RatingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RatingsRepository create(Ref ref) {
    return ratingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RatingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RatingsRepository>(value),
    );
  }
}

String _$ratingsRepositoryHash() => r'ec2a018ccdd165ccf96072b73b207ed956130445';
