import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/ui/auth/login.dart';
import 'package:inn/ui/auth/signup.dart';
import 'package:inn/ui/home/home.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  // redirect: (context, state) {
  // bool loggedIn = false;
  // bool loggingIn = state.uri.path == '/login';
  // if (!loggedIn && loggingIn) {
  // return '/login';
  // return '/signup';
  // }
  // return '/';
  // },
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
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => SignupPage(),
    ),
  ],
);
