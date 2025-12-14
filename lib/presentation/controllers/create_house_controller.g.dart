// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_house_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateHouseController)
const createHouseControllerProvider = CreateHouseControllerProvider._();

final class CreateHouseControllerProvider
    extends
        $AsyncNotifierProvider<CreateHouseController, CreateHouseFormState> {
  const CreateHouseControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createHouseControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createHouseControllerHash();

  @$internal
  @override
  CreateHouseController create() => CreateHouseController();
}

String _$createHouseControllerHash() =>
    r'138a46ee051872e7197397ead1db64ba3008b694';

abstract class _$CreateHouseController
    extends $AsyncNotifier<CreateHouseFormState> {
  FutureOr<CreateHouseFormState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<CreateHouseFormState>, CreateHouseFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CreateHouseFormState>,
                CreateHouseFormState
              >,
              AsyncValue<CreateHouseFormState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
