import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/shared/buttons.dart';
import 'package:inn/presentation/shared/terms_checkbox.dart';
import 'package:inn/presentation/shared/text_field.dart';
import 'package:inn/presentation/utils/validators.dart';

class CreateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController password1Controller;
  final VoidCallback onPressed;
  final ColorScheme cs;
  final double gap;
  final bool termsAgreed;
  final ValueChanged<bool?> termsOnPressed;
  final String buttonText;
  final bool isLoading;
  final bool obscurePassword;
  final bool obscureConfirm;
  final VoidCallback? onToggleObscure;
  final VoidCallback? onToggleObscureConfirm;

  const CreateForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.password1Controller,
    required this.onPressed,
    required this.cs,
    required this.gap,
    required this.termsAgreed,
    required this.termsOnPressed,
    required this.buttonText,
    required this.isLoading,
    required this.obscurePassword,
    required this.obscureConfirm,
    this.onToggleObscure,
    this.onToggleObscureConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
        child: Column(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: Column(
                children: [
                  InnTextField(
                    hint: 'Username',
                    controller: usernameController,
                    icon: Icons.person,
                    cs: cs,
                    validator: usernameValidator,
                    obscureText: false,
                    // onToggleObscure: () {},
                  ),
                  SizedBox(height: gap),
                  InnTextField(
                    hint: 'Email Address',
                    controller: emailController,
                    icon: Icons.email,
                    cs: cs,
                    obscureText: false,
                    validator: emailValidator,
                  ),
                  SizedBox(height: gap),
                  InnTextField(
                    hint: 'Password',
                    controller: passwordController,
                    icon: Icons.lock,
                    cs: cs,
                    isPassword: true,
                    obscureText: obscurePassword,
                    onToggleObscure: onToggleObscure,
                    validator: passwordValidator,
                  ),
                  SizedBox(height: gap),
                  InnTextField(
                    hint: 'Retype Password',
                    controller: password1Controller,
                    icon: Icons.lock,
                    cs: cs,
                    isPassword: true,
                    obscureText: obscureConfirm,
                    onToggleObscure: onToggleObscureConfirm,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please retype your password';
                      }

                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            AbsorbPointer(
              absorbing: isLoading,
              child: TermsCheckbox(
                onChanged: termsOnPressed,
                value: termsAgreed,
              ),
            ),
            SizedBox(height: gap),
            InnButton(
              onPressed: onPressed,
              buttonText: buttonText,
              cs: cs,
              isLoading: isLoading,
            ),
            SizedBox(height: 50.0),
            HaveAccount(cs: cs),
          ],
        ),
      ),
    );
  }
}

/* Have an account */
class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key, required this.cs});

  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    // return Flexible(
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: [
              const TextSpan(text: 'Have an account? '),
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.pop();
                  },
                // Accessibility hint for screen readers
                semanticsLabel: 'Takes user back to the login page',
              ),
            ],
          ),
          // ),
        ),
      ],
    );
  }
}
