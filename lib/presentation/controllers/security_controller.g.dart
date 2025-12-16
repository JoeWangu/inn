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
    r'4afed98f1daac20e11cd088032d6b0a74351d032';

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
