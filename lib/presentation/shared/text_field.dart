import 'package:flutter/material.dart';

class InnTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final ColorScheme cs;
  final ValueChanged<String>? onChanged;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  // final bool isConfirmPassword;
  // final bool obscurePassword;
  // final VoidCallback? onToggleObscure;
  // final bool? obscureConfirmPassword;
  // final VoidCallback? onToggleConfirmPassword;
  final String? Function(String?)? validator;

  const InnTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.icon,
    required this.cs,
    this.onChanged,
    this.isPassword = false,
    required this.obscureText,
    this.onToggleObscure,
    // this.isConfirmPassword = false,
    // required this.obscurePassword,
    // this.onToggleObscure,
    // this.obscureConfirmPassword = false,
    // this.onToggleConfirmPassword,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: cs.onSurface),
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      onChanged: onChanged,
      validator: validator,
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
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: onToggleObscure,
              )
            : null,
        // suffixIcon: isPassword
        //     ? IconButton(
        //         icon: Icon(
        //           obscurePassword ? Icons.visibility_off : Icons.visibility,
        //           color: Colors.grey,
        //         ),
        //         onPressed: isPassword
        //             ? onToggleObscure
        //             : isConfirmPassword
        //             ? onToggleConfirmPassword
        //             : null,
        //       )
        //     : null,
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
