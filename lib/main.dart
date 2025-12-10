/*
 * Copyright © 2025 Lumocious (lumocious@proton.me)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';
import 'package:inn/core/utils/jwt_utils.dart';
import 'package:inn/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A scroll behavior that enables mouse/track‑pad dragging for all axes.
class DesktopDragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
  };
}

// void main() {
//   runApp(const ProviderScope(child: InnApp()));
// }
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final container = ProviderContainer();
  final storage = container.read(secureStorageProvider);
  // final token = await storage.read(key: 'access_token');

  final values = await Future.wait([
    storage.read(key: 'access_token'),
    storage.read(key: 'refresh_token'),
    SharedPreferencesAsync().getBool('seen_onboarding'),
  ]);

  final accessToken = values[0] as String?;
  final refreshToken = values[1] as String?;
  final prefs = values[2] as bool?;

  final bool seenOnboarding = prefs ?? false;

  bool isLoggedIn = false;

  if (accessToken != null && !JwtUtils.isExpired(accessToken)) {
    // 1. Access Token is valid? Great.
    isLoggedIn = true;
  } else if (refreshToken != null && !JwtUtils.isExpired(refreshToken)) {
    // 2. Access Token expired, BUT Refresh Token is still valid?
    // We let them in! The 'AuthInterceptor' will detect the expired access token
    // on the very first API call and silently refresh it in the background.
    isLoggedIn = true;
  } else {
    // 3. Both are expired or missing? Login required.
    isLoggedIn = false;
  }

  String initialPath;

if (isLoggedIn) {
    // IF LOGGED IN -> GO TO HOMEPAGE (Ignores onboarding status)
    initialPath = '/';
  } else if (!seenOnboarding) {
    // IF NOT LOGGED IN + NOT ONBOARDED -> GO TO ONBOARDING
    initialPath = '/welcome';
  } else {
    // IF NOT LOGGED IN + ALREADY ONBOARDED -> GO LOGIN
    initialPath = '/login';
  }

  final appRouter = createRouter(initialPath);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: InnApp(router: appRouter,),
    ),
  );

  FlutterNativeSplash.remove();
}

class InnApp extends StatelessWidget {
  final GoRouter router;
  const InnApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Inn App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 43, 95, 86),
        ),
      ),
      routerConfig: router,
      scrollBehavior: DesktopDragScrollBehavior(),
    );
  }
}
