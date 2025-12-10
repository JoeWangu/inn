import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/domain/repositories/auth_repository.dart';
import 'dart:async';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async{
      final repository = ref.read(authRepositoryProvider);
      await repository.signUp(username: name, email: email, password: password);
    });
  }
}
