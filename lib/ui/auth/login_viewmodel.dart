import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewmodel extends _$LoginViewmodel {
  @override
  void build() {}

  // Future<bool> loginUser(String? email, String? password) async {
  //   final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  //   if (email != null && password != null) {
  //     final String? emailPref = await prefs.getString('email');
  //     final String? passwordPref = await prefs.getString('password');
  //     if (emailPref != null &&
  //         emailPref.isNotEmpty &&
  //         passwordPref != null &&
  //         passwordPref.isNotEmpty) {
  //       if (passwordPref == password && emailPref == email) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> loginUser({String? email, String? password}) async {
    if (email == null || password == null) return false;

    final prefs = SharedPreferencesAsync();

    final savedEmail = await prefs.getString('email') ?? '';
    final savedPassword = await prefs.getString('password') ?? '';

    final bool success =
        savedEmail.isNotEmpty &&
        savedPassword.isNotEmpty &&
        savedEmail == email &&
        savedPassword == password;
    await prefs.setBool('logged_in', true);
    return success;
  }
}
