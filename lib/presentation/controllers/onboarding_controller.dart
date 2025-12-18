import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/core/storage/shared_prefs_provider.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  Future<bool> build() async {
    final prefs = ref.watch(sharedPrefsAsyncProvider);
    return await prefs.getBool('seen_onboarding') ?? false;
  }

  Future<void> completeOnboarding() async {
    final prefs = ref.read(sharedPrefsAsyncProvider);
    await prefs.setBool('seen_onboarding', true);
    state = const AsyncData(true);
  }
}
