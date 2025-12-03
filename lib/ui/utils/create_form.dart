import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/ui/utils/buttons.dart';
import 'package:inn/ui/utils/confirm_password.dart';
import 'package:inn/ui/utils/terms_checkbox.dart';
import 'package:inn/ui/utils/text_field.dart';
import 'package:inn/ui/utils/validators.dart';

class CreateForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController password1Controller;
  final VoidCallback onPressed;
  final ColorScheme cs;
  final double gap;
  final bool termsAgreed;
  final ValueChanged<bool?> termsOnPressed;
  final String buttonText;

  const CreateForm({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.password1Controller,
    required this.onPressed,
    required this.cs,
    required this.gap,
    required this.termsAgreed,
    required this.termsOnPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
        child: Column(
          children: [
            InnTextField(
              hint: 'Full Name',
              controller: fullNameController,
              icon: Icons.person,
              cs: cs,
            ),
            SizedBox(height: gap),
            InnTextField(
              hint: 'Email Address',
              controller: emailController,
              icon: Icons.email,
              cs: cs,
              isEmail: true,
            ),
            SizedBox(height: gap),
            InnTextField(
              hint: 'Password',
              controller: passwordController,
              icon: Icons.lock,
              cs: cs,
              isPassword: true,
            ),
            SizedBox(height: gap),
            InnPass1TextField(
              hint: 'Retype Password',
              controller: password1Controller,
              icon: Icons.lock,
              cs: cs,
              isPassword: true,
              customValidator: (value) {
                final base = passwordValidator(value);
                if (base != null) return '';

                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            SizedBox(height: 40),
            TermsCheckbox(onChanged: termsOnPressed, value: termsAgreed),
            SizedBox(height: gap),
            InnButton(onPressed: onPressed, buttonText: buttonText, cs: cs),
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
