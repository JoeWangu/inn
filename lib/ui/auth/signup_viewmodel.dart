import 'package:inn/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_viewmodel.g.dart';

@riverpod
class SignupViewmodel extends _$SignupViewmodel {
  @override
  void build() async {}

  Future<bool> signupUser(User? user) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    if (user != null) {
      await prefs.setString('userName', user.fullName);
      await prefs.setString('email', user.email);
      await prefs.setString('password', user.password);
      await prefs.setBool('logged_in', true);
      return true;
    } else {
      return false;
    }
  }
}
