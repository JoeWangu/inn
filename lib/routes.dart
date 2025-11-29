import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/ui/auth/login.dart';
import 'package:inn/ui/home/home.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final loggedIn = false;
    final loggingIn = state.namedLocation('/login') == '/login';
    if (!loggedIn && loggingIn) {
      return '/login';
    }
    return '/';
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
      builder: (context, state) => LoginPage(),
    ),
  ],
);
