// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_check_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthCheckController)
const authCheckControllerProvider = AuthCheckControllerProvider._();

final class AuthCheckControllerProvider
    extends $AsyncNotifierProvider<AuthCheckController, bool> {
  const AuthCheckControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authCheckControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authCheckControllerHash();

  @$internal
  @override
  AuthCheckController create() => AuthCheckController();
}

String _$authCheckControllerHash() =>
    r'eb3db19c3ba2d8a068e70fa1248d67cb7a110dfe';

abstract class _$AuthCheckController extends $AsyncNotifier<bool> {
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
