import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/domain/repositories/auth_repository.dart';
import 'package:inn/presentation/controllers/auth_controllers/auth_check_controller.dart';
import 'dart:async';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.login(email: email, password: password);
    });
    if (ref.mounted) {
      state = newState;
      if (state.hasValue && !state.hasError) {
        ref.invalidate(authCheckControllerProvider);
      }
    }
  }
}
