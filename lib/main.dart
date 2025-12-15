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

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';
import 'package:inn/core/theme/app_theme.dart';
import 'package:inn/core/utils/jwt_utils.dart';
import 'package:inn/presentation/providers/theme_provider.dart';
import 'package:inn/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final container = ProviderContainer();
  final storage = container.read(secureStorageProvider);

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
    isLoggedIn = true;
  } else if (refreshToken != null && !JwtUtils.isExpired(refreshToken)) {
    isLoggedIn = true;
  } else {
    isLoggedIn = false;
  }

  String initialPath;

  if (isLoggedIn) {
    initialPath = '/';
  } else if (!seenOnboarding) {
    initialPath = '/welcome';
  } else {
    initialPath = '/login';
  }

  final appRouter = createRouter(initialPath);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: InnApp(router: appRouter),
    ),
  );

  FlutterNativeSplash.remove();
}

class InnApp extends ConsumerWidget {
  final GoRouter router;
  const InnApp({super.key, required this.router});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettingsAsync = ref.watch(themeControllerProvider);

    return themeSettingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Error: $err'))),
      ),
      data: (themeSettings) {
        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            ColorScheme? lightScheme;
            ColorScheme? darkScheme;
            Color? targetSeedColor;

            if (themeSettings.colorSource == AppColorSource.dynamic) {
              lightScheme = lightDynamic;
              darkScheme = darkDynamic;
            } else if (themeSettings.colorSource == AppColorSource.custom) {
              targetSeedColor = themeSettings.customColor;
            }

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Inn App',
              theme: AppTheme.createTheme(
                colorScheme: lightScheme,
                brightness: Brightness.light,
                seedColor: targetSeedColor,
              ),
              darkTheme: AppTheme.createTheme(
                colorScheme: darkScheme,
                brightness: Brightness.dark,
                seedColor: targetSeedColor,
              ),
              themeMode: themeSettings.themeMode,
              routerConfig: router,
              scrollBehavior: DesktopDragScrollBehavior(),
            );
          },
        );
      },
    );
  }
}
