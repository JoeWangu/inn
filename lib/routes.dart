import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/debug.dart';
import 'package:inn/presentation/controllers/auth_controllers/auth_check_controller.dart';
import 'package:inn/presentation/pages/auth/login.dart';
import 'package:inn/presentation/pages/auth/signup.dart';
import 'package:inn/presentation/pages/explore/explore.dart';
import 'package:inn/presentation/pages/favorites/favorites.dart';
import 'package:inn/presentation/pages/home/home.dart';
import 'package:inn/presentation/pages/home/house_details_page.dart';
import 'package:inn/presentation/pages/home/search_page.dart';
import 'package:inn/presentation/pages/onboarding/onboarding.dart';
import 'package:inn/presentation/pages/profile/profile_page.dart';
import 'package:inn/presentation/pages/profile/my_properties_page.dart';
import 'package:inn/presentation/pages/create_house/create_house_page.dart';
import 'package:inn/presentation/shared/scaffold_with_nav_bar.dart';
import 'package:inn/data/models/user_profile_model.dart';
import 'package:inn/presentation/pages/profile/edit_profile_page.dart';
import 'package:inn/presentation/pages/create_house/manage_images_page.dart';
import 'package:inn/presentation/pages/home/photo_gallery_page.dart';
import 'package:inn/presentation/pages/settings/settings_page.dart';
import 'package:inn/presentation/pages/settings/security_settings_page.dart';
import 'package:inn/presentation/pages/auth/lock_screen_page.dart';
import 'package:inn/presentation/controllers/onboarding_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authAsync = ref.watch(authCheckControllerProvider);
  final onboardingAsync = ref.watch(onboardingControllerProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: Listenable.merge([
      ValueNotifier(authAsync),
      ValueNotifier(onboardingAsync),
    ]),
    redirect: (context, state) {
      // Wait for both auth and onboarding to be resolved
      if (authAsync.isLoading || onboardingAsync.isLoading) {
        return null;
      }

      final isLoggedIn = authAsync.asData?.value ?? false;
      final seenOnboarding = onboardingAsync.asData?.value ?? false;

      final isLogin = state.uri.path == '/login';
      final isSignup = state.uri.path == '/signup';
      final isWelcome = state.uri.path == '/welcome';

      // 1. Onboarding Check
      if (!seenOnboarding) {
        if (isWelcome) return null;
        return '/welcome';
      }

      // 2. Auth Check
      if (!isLoggedIn) {
        if (isLogin || isSignup || isWelcome) {
          return null;
        }
        return '/login';
      }

      // 3. Logged in and on auth/onboarding pages, go home
      if (isLoggedIn && (isLogin || isSignup || isWelcome)) {
        return '/';
      }

      return null;
    },
    routes: <RouteBase>[
      // Routes WITHOUT the Bottom Bar
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        name: 'app_colors',
        path: '/colors',
        builder: (context, state) => const ColorsPage(),
      ),
      GoRoute(
        name: 'welcome',
        path: '/welcome',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // Routes WITH the Bottom Bar (Wrapped in Shell)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'home',
                path: '/',
                builder: (BuildContext context, GoRouterState state) =>
                    const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'explore',
                path: '/explore',
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'favorites',
                path: '/favorites',
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: 'profile',
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'house-details',
        path: '/house-details',
        builder: (context, state) {
          final house = state.extra as Map<String, dynamic>;
          return HouseDetailsPage(
            house: house['house'] as HouseModel,
            heroTag: house['tag'] as String,
          );
        },
      ),
      GoRoute(
        name: 'search',
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        name: 'my-properties',
        path: '/my-properties',
        builder: (context, state) => const MyPropertiesPage(),
      ),
      GoRoute(
        name: 'create-house',
        path: '/create-house',
        builder: (context, state) {
          final house = state.extra as HouseModel?;
          return CreateHousePage(house: house);
        },
      ),
      GoRoute(
        name: 'edit-profile',
        path: '/edit-profile',
        builder: (context, state) {
          final profile = state.extra as UserProfileModel?;
          return EditProfilePage(userProfile: profile);
        },
      ),
      GoRoute(
        name: 'manage-images',
        path: '/manage-images',
        builder: (context, state) {
          final rentalId = state.extra as int;
          return ManageImagesPage(rentalId: rentalId);
        },
      ),
      GoRoute(
        name: 'photo-gallery',
        path: '/photo-gallery',
        builder: (context, state) {
          final rentalId = state.extra as int;
          return PhotoGalleryPage(rentalId: rentalId);
        },
      ),
      GoRoute(
        name: 'settings',
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        name: 'security-settings',
        path: '/security_settings',
        builder: (context, state) => const SecuritySettingsPage(),
      ),
      GoRoute(
        name: 'lock-screen',
        path: '/lock_screen',
        builder: (context, state) => const LockScreenPage(),
      ),
    ],
  );
}
