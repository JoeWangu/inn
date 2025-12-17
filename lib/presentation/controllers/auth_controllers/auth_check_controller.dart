import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';

part 'auth_check_controller.g.dart';

@riverpod
class AuthCheckController extends _$AuthCheckController {
  @override
  Future<bool> build() async {
    final storage = ref.watch(secureStorageProvider);
    final token = await storage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    final storage = ref.read(secureStorageProvider);
    await storage.deleteAll();
    state = const AsyncData(false);
  }
}
