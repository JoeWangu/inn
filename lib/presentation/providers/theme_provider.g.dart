// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeController)
const themeControllerProvider = ThemeControllerProvider._();

final class ThemeControllerProvider
    extends $AsyncNotifierProvider<ThemeController, ThemeSettings> {
  const ThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();
}

String _$themeControllerHash() => r'7fa7771116380438af33ab05c29be23cb6ceb07c';

abstract class _$ThemeController extends $AsyncNotifier<ThemeSettings> {
  FutureOr<ThemeSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ThemeSettings>, ThemeSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemeSettings>, ThemeSettings>,
              AsyncValue<ThemeSettings>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
