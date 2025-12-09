// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:inn/domain/entities/user_entity.dart';
// import 'package:inn/domain/entities/auth_token.dart';
// import 'package:inn/domain/repositories/auth_repository.dart';

// part 'signup_usecase.g.dart';

// @riverpod
// class SignupUseCase extends _$SignupUseCase {
//   @override
//   FutureOr<AuthToken> build() {
//     return AuthToken(
//       accessToken: '',
//       refreshToken: '',
//       expiresAt: DateTime.utc(2026, 1, 1),
//     );
//   }

//   Future<void> execute(UserEntity user) async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() async {
//       final token = await ref.read(authRepositoryProvider.notifier).signupUser(user);
//     });
//   }
// }
