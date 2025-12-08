// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignupViewmodel)
const signupViewmodelProvider = SignupViewmodelProvider._();

final class SignupViewmodelProvider
    extends $NotifierProvider<SignupViewmodel, void> {
  const SignupViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signupViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signupViewmodelHash();

  @$internal
  @override
  SignupViewmodel create() => SignupViewmodel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$signupViewmodelHash() => r'879243cab7de1381d2b3f6a3b8bd4f8ce3d5d337';

abstract class _$SignupViewmodel extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
