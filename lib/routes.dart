import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/debug.dart';
import 'package:inn/presentation/pages/auth/login.dart';
import 'package:inn/presentation/pages/auth/signup.dart';
import 'package:inn/presentation/pages/explore/explore.dart';
import 'package:inn/presentation/pages/favorites/favorites.dart';
import 'package:inn/presentation/pages/home/home.dart';
import 'package:inn/presentation/pages/onboarding/onboarding.dart';
import 'package:inn/presentation/pages/resthome/resthome.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final bool seenOnboarding = await prefs.getBool('seen_onboarding') ?? false;
    final bool loggedIn = await prefs.getBool('logged_in') ?? false;
    final isFirstLaunch = !seenOnboarding;

    // final token = await prefs.getString('auth_token');
    // final loggedIn = token != null && token.isNotEmpty;
    // bool loggingIn = state.uri.path == '/login';
    // current path
    final path = state.uri.path;

    if (isFirstLaunch && path != '/welcome') {
      // return '/login';
      return '/welcome';
    }

    if (!loggedIn &&
        path != '/login' &&
        path != '/welcome' &&
        path != '/signup') {
      return '/login';
    }

    if (!isFirstLaunch && path == '/welcome') {
      return '/';
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
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
    GoRoute(
      name: 'explore',
      path: '/explore',
      builder: (context, state) => const ExplorePage(),
    ),
    GoRoute(
      name: 'favorites',
      path: '/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
    GoRoute(
      name: 'rest',
      path: '/rest',
      builder: (context, state) => const Resthome(),
    ),
  ],
);
