import 'package:flutter/material.dart';
import 'package:inn/presentation/utils/validators.dart';

class InnTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final bool isEmail;
  final bool isPassword;
  final bool isPassword1;
  final ColorScheme cs;
  final ValueChanged<String>? onChanged;

  const InnTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.icon,
    this.isEmail = false,
    this.isPassword = false,
    this.isPassword1 = false,
    required this.cs,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: cs.onSurface),
      controller: controller,
      obscureText: isPassword,
      onChanged: onChanged,
      validator: isEmail
          ? emailValidator
          : isPassword
          ? passwordValidator
          : requiredValidator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          // color: Colors.grey,
          color: cs.onSurface.withValues(alpha: 0.4),
        ),
        // hintStyle: TextStyle(),
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 10.0, 0),
          child: Icon(icon, color: cs.onSurface.withValues(alpha: 0.4)),
        ),
        filled: true,
        // fillColor: Colors.grey.shade100,
        fillColor: cs.surface,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: cs.outline,
            // color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            // color: Color(0xFF2B5F56),
            color: cs.primary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            // color: Colors.indigo,
            color: cs.inversePrimary,
            width: 1,
          ),
        ),
      ),
    );
  }
}
