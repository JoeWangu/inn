String? usernameValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Required';
  if (v.length < 3) return 'Must have 3 or more letters';
  return null;
}

String? emailValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Email required';
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Enter a valid email';
  return null;
}

String? passwordValidator(String? v) {
  if (v == null || v.isEmpty) return 'Password required';
  if (v.length < 8) return 'Minimum 8 characters';
  if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Must contain an uppercase letter';
  if (!RegExp(r'[0-9]').hasMatch(v)) return 'Must contain a number';
  return null;
}
