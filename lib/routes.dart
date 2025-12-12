import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/debug.dart';
import 'package:inn/presentation/pages/auth/login.dart';
import 'package:inn/presentation/pages/auth/signup.dart';
import 'package:inn/presentation/pages/explore/explore.dart';
import 'package:inn/presentation/pages/favorites/favorites.dart';
import 'package:inn/presentation/pages/home/home.dart';
import 'package:inn/presentation/pages/home/house_details_page.dart';
import 'package:inn/presentation/pages/home/search_page.dart';
import 'package:inn/presentation/pages/onboarding/onboarding.dart';
import 'package:inn/presentation/pages/profile/profile_page.dart';
import 'package:inn/presentation/shared/scaffold_with_nav_bar.dart';

// final GoRouter router =
GoRouter createRouter(String initialPath) {
  return GoRouter(
    initialLocation: initialPath,
    /*     // redirect: (context, state) async {
    //   final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    //   final bool seenOnboarding =
    //       await prefs.getBool('seen_onboarding') ?? false;
    //   final bool loggedIn = await prefs.getBool('logged_in') ?? false;
    //   final isFirstLaunch = !seenOnboarding;

    //   // final token = await prefs.getString('auth_token');
    //   // final loggedIn = token != null && token.isNotEmpty;
    //   // bool loggingIn = state.uri.path == '/login';
    //   // current path
    //   final path = state.uri.path;

    //   if (isFirstLaunch && path != '/welcome') {
    //     // return '/login';
    //     return '/welcome';
    //   }

    //   if (!loggedIn &&
    //       path != '/login' &&
    //       path != '/welcome' &&
    //       path != '/signup') {
    //     return '/login';
    //   }

    //   if (!isFirstLaunch && path == '/welcome') {
    //     return '/';
    //   }

    //   return null;
    // }, */
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
    ],
  );
}
