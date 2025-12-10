import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';

part 'auth_check_controller.g.dart';

@riverpod
Future<bool> checkAuthStatus(Ref ref) async {
  final storage = ref.watch(secureStorageProvider);
  
  // 1. Read the token
  final token = await storage.read(key: 'access_token');
  
  // 2. Simple check: Does it exist?
  // (Optional: You can decode it here to check expiration if you want to be extra safe)
  return token != null && token.isNotEmpty;
}
