import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_prefs_provider.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesAsync sharedPrefsAsync(Ref ref) {
  return SharedPreferencesAsync();
}
