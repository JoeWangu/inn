import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';

part 'auth_check_controller.g.dart';

@riverpod
Future<bool> checkAuthStatus(Ref ref) async {
  final storage = ref.watch(secureStorageProvider);

  final token = await storage.read(key: 'access_token');

  return token != null && token.isNotEmpty;
}
