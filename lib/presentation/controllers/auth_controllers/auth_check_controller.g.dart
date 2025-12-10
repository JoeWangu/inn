// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_check_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkAuthStatus)
const checkAuthStatusProvider = CheckAuthStatusProvider._();

final class CheckAuthStatusProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const CheckAuthStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkAuthStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkAuthStatusHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return checkAuthStatus(ref);
  }
}

String _$checkAuthStatusHash() => r'52238472d9ac6a93f0fd5e664facfeafca1a4594';
