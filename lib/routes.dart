import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/debug.dart';
import 'package:inn/ui/auth/login.dart';
import 'package:inn/ui/auth/signup.dart';
import 'package:inn/ui/home/home.dart';
import 'package:inn/ui/home/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  initialLocation: '/welcome',
  redirect: (context, state) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final seenOnboarding = await prefs.getBool('seen_onboarding') ?? false;
    final isFirstLaunch = !seenOnboarding;
    bool loggedIn = false;

    // final token = await prefs.getString('auth_token');
    // final loggedIn = token != null && token.isNotEmpty;
    // bool loggingIn = state.uri.path == '/login';
    // current path
    final path = state.uri.path;

    if (isFirstLaunch && path != '/welcome') {
      // return '/login';
      return '/welcome';
    }

    if (!loggedIn && path != '/login' && path != '/welcome') {
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
  ],
);
