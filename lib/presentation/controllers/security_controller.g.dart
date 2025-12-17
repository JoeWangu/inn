// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SecurityController)
const securityControllerProvider = SecurityControllerProvider._();

final class SecurityControllerProvider
    extends $AsyncNotifierProvider<SecurityController, SecurityState> {
  const SecurityControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securityControllerHash();

  @$internal
  @override
  SecurityController create() => SecurityController();
}

String _$securityControllerHash() =>
    r'73eca1ca8d11b33e8eeb30f7baff5f7e22ce18de';

abstract class _$SecurityController extends $AsyncNotifier<SecurityState> {
  FutureOr<SecurityState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SecurityState>, SecurityState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SecurityState>, SecurityState>,
              AsyncValue<SecurityState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
