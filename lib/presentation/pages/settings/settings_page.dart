import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/core/theme/app_theme.dart';
import 'package:inn/presentation/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettings = ref.watch(themeControllerProvider);
    final themeController = ref.read(themeControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Appearance'),
          _buildThemeModeSelector(
            context,
            themeSettings.value,
            themeController,
          ),
          const Divider(),
          _buildColorSourceSelector(
            context,
            themeSettings.value,
            themeController,
          ),
          if (hasError(themeSettings))
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error loading settings',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
    );
  }

  bool hasError(AsyncValue<ThemeSettings> settings) {
    return settings.hasError;
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildThemeModeSelector(
    BuildContext context,
    ThemeSettings? settings,
    ThemeController controller,
  ) {
    if (settings == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Theme Mode'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(Icons.brightness_auto),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.light_mode),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.dark_mode),
              ),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (Set<ThemeMode> newSelection) {
              controller.setThemeMode(newSelection.first);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildColorSourceSelector(
    BuildContext context,
    ThemeSettings? settings,
    ThemeController controller,
  ) {
    if (settings == null) return const SizedBox.shrink();

    return RadioGroup<AppColorSource>(
      groupValue: settings.colorSource,
      onChanged: (AppColorSource? value) {
        if (value == null) return;
        if (value == AppColorSource.custom) {
          // If switching to custom, set a default if none exists, or keep existing
          if (settings.customColor == null) {
            controller.setCustomColor(AppTheme.customColors.first.color);
          } else {
            controller.setColorSource(value);
          }
        } else {
          controller.setColorSource(value);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('Color Theme'),
          ),
          const RadioListTile<AppColorSource>(
            title: Text('Official Colors'),
            subtitle: Text('Use the default app colors'),
            value: AppColorSource.official,
          ),
          const RadioListTile<AppColorSource>(
            title: Text('Wallpaper Colors (Dynamic)'),
            subtitle: Text('Adapt to your device wallpaper'),
            value: AppColorSource.dynamic,
          ),
          const RadioListTile<AppColorSource>(
            title: Text('Custom Color'),
            subtitle: Text('Choose your favorite color'),
            value: AppColorSource.custom,
          ),
          if (settings.colorSource == AppColorSource.custom)
            _buildCustomColorPicker(context, settings, controller),
        ],
      ),
    );
  }

  Widget _buildCustomColorPicker(
    BuildContext context,
    ThemeSettings settings,
    ThemeController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: AppTheme.customColors.map((option) {
          final isSelected = settings.customColor == option.color;
          return GestureDetector(
            onTap: () => controller.setCustomColor(option.color),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: option.color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 3,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 28)
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
