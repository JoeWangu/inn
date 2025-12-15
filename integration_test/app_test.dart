import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:inn/main.dart'; // For InnApp
import 'package:inn/routes.dart'; // For createRouter
import 'package:inn/domain/repositories/auth_repository.dart';
import 'package:inn/domain/repositories/house_repository.dart';
import 'package:inn/domain/repositories/favorites_repository.dart';
import 'package:inn/data/models/auth_models/login_response.dart';
import 'package:inn/data/models/user_model.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/presentation/providers/theme_provider.dart';

import '../test/helpers/test_helper.mocks.dart';

class FakeThemeController extends ThemeController {
  @override
  Future<ThemeSettings> build() async {
    return const ThemeSettings();
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthRepository mockAuthRepository;
  late MockHouseRepository mockHouseRepository;
  late MockFavoritesRepository mockFavoritesRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockHouseRepository = MockHouseRepository();
    mockFavoritesRepository = MockFavoritesRepository();
  });

  final tLoginResponse = LoginResponse(
    user: UserModel(email: 'test@example.com', username: 'tester'),
    token: 'token',
    refresh: 'refresh',
    created: false,
  );

  final tHouse = HouseModel(
    id: 1,
    price: 1500,
    totalUnits: 1,
    datePosted: DateTime.now(),
    dateModified: DateTime.now(),
    available: true,
    isActive: true,
    avgRating: 4.5,
    authorDetail: const AuthorDetail(id: 1),
    title: 'Test House',
    neighborhood: const Neighborhood(id: 1, name: 'Test Hood'),
    category: 'Apartment',
  );

  testWidgets('App Flow: Login -> Home -> House Details', (
    WidgetTester tester,
  ) async {
    // 1. Setup Mocks
    // Auth - Login Success
    when(
      mockAuthRepository.login(
        email: 'test@example.com',
        password: 'password123',
      ),
    ).thenAnswer((_) async => tLoginResponse);

    // House - Home Data
    when(
      mockHouseRepository.shouldFetchHomeData(),
    ).thenAnswer((_) async => true);
    when(mockHouseRepository.fetchRecentHouses()).thenAnswer((_) async {});
    when(
      mockHouseRepository.watchHouses(),
    ).thenAnswer((_) => Stream.value([tHouse]));

    // Favorites - Initial Empty
    when(mockFavoritesRepository.syncFavorites()).thenAnswer((_) async {});
    when(
      mockFavoritesRepository.watchFavoriteIds(),
    ).thenAnswer((_) => Stream.value([]));

    // 2. Pump App
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          houseRepositoryProvider.overrideWithValue(mockHouseRepository),
          favoritesRepositoryProvider.overrideWithValue(
            mockFavoritesRepository,
          ),
          themeControllerProvider.overrideWith(() => FakeThemeController()),
        ],
        child: InnApp(router: createRouter('/login')),
      ),
    );
    await tester.pumpAndSettle();

    // 3. Verify Login Page
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));

    // 4. Perform Login
    // Note: Desktop view uses 'Email', Mobile uses 'Email or Phone'.
    // Integration test on Linux uses Desktop view.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'test@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );
    await tester.tap(find.text('Login'));

    // Wait for async login and navigation
    await tester.pumpAndSettle();

    // 5. Verify Home Page
    expect(find.text('Recently Viewed'), findsOneWidget);
    expect(find.text('Test House'), findsAtLeastNWidgets(1));

    // 6. Navigate to Details
    // Tap the first house card found
    await tester.tap(find.text('Test House').first);
    await tester.pumpAndSettle();

    // 7. Verify Details Page
    // Assuming Details page shows title
    expect(find.text('Test House'), findsAtLeastNWidgets(1));
    // Verify "Book Now" or similar details page specific widget if possible context is 'HouseDetailsPage'
  });
}
