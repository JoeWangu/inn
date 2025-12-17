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
import 'package:inn/core/theme/app_theme.dart';
import 'package:inn/presentation/providers/theme_provider.dart';
import 'package:inn/routes.dart';
import 'package:inn/presentation/widgets/app_lifecycle_wrapper.dart';

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

  runApp(const ProviderScope(child: InnApp()));

  FlutterNativeSplash.remove();
}

class InnApp extends ConsumerWidget {
  const InnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettingsAsync = ref.watch(themeControllerProvider);
    final router = ref.watch(routerProvider);

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

            return AppLifecycleWrapper(
              router: router,
              child: MaterialApp.router(
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
              ),
            );
          },
        );
      },
    );
  }
}
