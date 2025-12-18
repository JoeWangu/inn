import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:inn/presentation/shared/house_card.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/favorites_repository.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockFavoritesRepository mockFavoritesRepository;

  setUp(() {
    mockFavoritesRepository = MockFavoritesRepository();
  });

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

  testWidgets('HouseCard renders correctly and handles tap', (
    WidgetTester tester,
  ) async {
    // Stub repo methods used by Favorites provider
    when(mockFavoritesRepository.syncFavorites()).thenAnswer((_) async {});
    when(
      mockFavoritesRepository.watchFavoriteIds(),
    ).thenAnswer((_) => Stream.value([1])); // House 1 is favorite

    // Setup GoRouter to verify navigation
    bool pushed = false;
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: HouseCard(house: tHouse, cs: Theme.of(context).colorScheme),
          ),
        ),
        GoRoute(
          name: 'house-details',
          path: '/details',
          builder: (context, state) {
            pushed = true;
            return const Scaffold(body: Text('Details'));
          },
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(
            mockFavoritesRepository,
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );

    // Allow image (error) to settle? CachedNetworkImage might need time.
    await tester.pumpAndSettle();

    // Verify Title and Price
    expect(find.text('Test House'), findsOneWidget);
    expect(find.text('KES 1500'), findsOneWidget);
    expect(find.text('Test Hood'), findsOneWidget);

    // Verify Favorite Icon (id is 1, so it should be favorite)
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Tap to navigate
    await tester.tap(find.byType(HouseCard));
    await tester.pumpAndSettle();

    expect(pushed, isTrue);
  });

  testWidgets('HouseCard favorite button toggles', (WidgetTester tester) async {
    // Stub for non-favorite initially
    when(mockFavoritesRepository.syncFavorites()).thenAnswer((_) async {});
    when(
      mockFavoritesRepository.watchFavoriteIds(),
    ).thenAnswer((_) => Stream.value([])); // Not favorite
    when(mockFavoritesRepository.toggleFavorite(any)).thenAnswer((_) async {});

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: HouseCard(house: tHouse, cs: Theme.of(context).colorScheme),
          ),
        ),
        GoRoute(
          name: 'house-details',
          path: '/details',
          builder: (_, _) => const SizedBox(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(
            mockFavoritesRepository,
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    // Find heart icon button (it's in a stack)
    // There are 2 icons: favorite and favorite_border.
    // Since not favorite, valid icon is favorite_border
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    // Tap the favorite button (it's the small circle container)
    // We can find by icon and tap that
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    verify(mockFavoritesRepository.toggleFavorite(tHouse)).called(1);
  });
}
