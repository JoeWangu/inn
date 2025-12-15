import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:inn/domain/repositories/auth_repository.dart';
import 'package:inn/data/models/user_model.dart';
import 'package:inn/data/models/auth_models/signup_response.dart';
import 'package:inn/data/models/auth_models/login_response.dart';
import 'package:inn/data/models/user_profile_model.dart';
import 'package:inn/data/models/auth_models/sign_up_request.dart';
import 'package:inn/data/models/auth_models/login_request.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthApi mockAuthApi;
  late MockFlutterSecureStorage mockStorage;
  late MockAppDatabase mockDatabase;
  late AuthRepository authRepository;

  setUp(() {
    mockAuthApi = MockAuthApi();
    mockStorage = MockFlutterSecureStorage();
    mockDatabase = MockAppDatabase();
    authRepository = AuthRepository(
      api: mockAuthApi,
      storage: mockStorage,
      db: mockDatabase,
    );
  });

  const tUsername = 'testuser';
  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  final tUserModel = UserModel(email: tEmail, username: tUsername);

  group('signUp', () {
    final tSignUpRequest = SignUpRequest(
      username: tUsername,
      email: tEmail,
      password: tPassword,
    );
    final tSignupResponse = SignupResponse(
      user: tUserModel,
      token: 'access_token',
      refresh: 'refresh_token',
      message: 'Success',
    );

    test(
      'should return SignupResponse and cache tokens when call to api is successful',
      () async {
        // arrange
        when(
          mockAuthApi.signUp(tSignUpRequest),
        ).thenAnswer((_) async => tSignupResponse);
        when(
          mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
        ).thenAnswer((_) async => {});

        // act
        final result = await authRepository.signUp(
          username: tUsername,
          email: tEmail,
          password: tPassword,
        );

        // assert
        expect(result, tSignupResponse);
        verify(mockAuthApi.signUp(tSignUpRequest));
        verify(mockStorage.write(key: 'access_token', value: 'access_token'));
        verify(mockStorage.write(key: 'refresh_token', value: 'refresh_token'));
      },
    );
  });

  group('login', () {
    final tLoginRequest = LoginRequest(email: tEmail, password: tPassword);
    final tLoginResponse = LoginResponse(
      user: tUserModel,
      token: 'access_token',
      refresh: 'refresh_token',
      created: false,
    );

    test(
      'should return LoginResponse and cache tokens when call to api is successful',
      () async {
        // arrange
        when(
          mockAuthApi.login(tLoginRequest),
        ).thenAnswer((_) async => tLoginResponse);
        when(
          mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
        ).thenAnswer((_) async => {});

        // act
        final result = await authRepository.login(
          email: tEmail,
          password: tPassword,
        );

        // assert
        expect(result, tLoginResponse);
        verify(mockAuthApi.login(tLoginRequest));
        verify(mockStorage.write(key: 'access_token', value: 'access_token'));
        verify(mockStorage.write(key: 'refresh_token', value: 'refresh_token'));
      },
    );
  });

  group('logout', () {
    test('should delete all tokens from storage', () async {
      // arrange
      when(mockStorage.deleteAll()).thenAnswer((_) async => {});

      // act
      await authRepository.logout();

      // assert
      verify(mockStorage.deleteAll());
    });
  });

  group('getUserProfile', () {
    final tUserProfile = UserProfileModel(
      firstName: 'Test',
      lastName: 'User',
      profilePicture: 'https://example.com/pic.jpg',
    );

    test(
      'should return remote profile and save to local db when forceRefresh is true',
      () async {
        // arrange
        when(
          mockAuthApi.getUserProfile(),
        ).thenAnswer((_) async => tUserProfile);
        when(
          mockDatabase.insertUserProfile(tUserProfile),
        ).thenAnswer((_) async => {});

        // act
        final result = await authRepository.getUserProfile(forceRefresh: true);

        // assert
        expect(result, tUserProfile);
        verify(mockAuthApi.getUserProfile());
        verify(mockDatabase.insertUserProfile(tUserProfile));
      },
    );

    test(
      'should return local profile if available and forceRefresh is false',
      () async {
        // arrange
        when(
          mockDatabase.getUserProfile(),
        ).thenAnswer((_) async => tUserProfile);

        // act
        final result = await authRepository.getUserProfile(forceRefresh: false);

        // assert
        expect(result, tUserProfile);
        verify(mockDatabase.getUserProfile());
        verifyZeroInteractions(mockAuthApi);
      },
    );

    test('should return remote profile if local is null', () async {
      // arrange
      when(mockDatabase.getUserProfile()).thenAnswer((_) async => null);
      when(mockAuthApi.getUserProfile()).thenAnswer((_) async => tUserProfile);
      when(
        mockDatabase.insertUserProfile(tUserProfile),
      ).thenAnswer((_) async => {});

      // act
      final result = await authRepository.getUserProfile(forceRefresh: false);

      // assert
      expect(result, tUserProfile);
      verify(mockDatabase.getUserProfile());
      verify(mockAuthApi.getUserProfile());
      verify(mockDatabase.insertUserProfile(tUserProfile));
    });
  });
}
