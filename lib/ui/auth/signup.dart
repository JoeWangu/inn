import 'package:flutter/material.dart';
import 'package:inn/debug.dart';
import 'package:inn/ui/utils/buttons.dart';
import 'package:inn/ui/utils/terms_checkbox.dart';
import 'package:inn/ui/utils/text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

void _signUp() {
  print('sign up pressed');
}

class _SignupPageState extends State<SignupPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password1Controller = TextEditingController();
  bool _termsAgreed = true;

  void _termsOnPressed(bool? newValue) => setState(() {
    _termsAgreed = newValue!;

    if (_termsAgreed) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // final width = constraints.maxWidth;
          // final height = constraints.maxHeight;

          return Column(
            children: [
              _title(),
              SizedBox(height: 10),
              _form(
                fullNameController: _fullNameController,
                emailController: _emailController,
                passwordController: _passwordController,
                password1Controller: _password1Controller,
                onPressed: _signUp,
                cs: cs,
                gap: 20,
                termsAgreed: _termsAgreed,
                termsOnPressed: _termsOnPressed,
              ),
              // SizedBox(height: 10.0),
              // Expanded(
              //   // ← This prevents infinity overflow
              //   child: Container(
              //     margin: const EdgeInsets.all(16),
              //     decoration: BoxDecoration(
              //       color: Colors.white.withAlpha(255),
              //       borderRadius: BorderRadius.circular(16),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black26,
              //           blurRadius: 10,
              //           offset: Offset(0, 4),
              //         ),
              //       ],
              //     ),
              //     child: const ColorPaletteDebug(), // ← Your debug widget
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  Widget _title() {
    return Container();
  }

  Widget _form({
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController password1Controller,
    required VoidCallback onPressed,
    required ColorScheme cs,
    required double gap,
    required bool termsAgreed,
    required ValueChanged<bool?> termsOnPressed,
  }) {
    // final String tc = 'Terms & Conditions';
    // Color getColor(Set<WidgetState> states) {
    //   const Set<WidgetState> interactiveStates = <WidgetState>{
    //     WidgetState.pressed,
    //     WidgetState.hovered,
    //     WidgetState.focused,
    //   };
    //   if (states.any(interactiveStates.contains)) {
    //     return Colors.blue;
    //   }
    //   return Colors.red;
    // }

    return Form(
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
            ),
            SizedBox(height: gap),
            InnTextField(
              hint: 'Password',
              controller: passwordController,
              icon: Icons.lock,
              cs: cs,
            ),
            SizedBox(height: gap),
            InnTextField(
              hint: 'Retype Password',
              controller: password1Controller,
              icon: Icons.lock,
              cs: cs,
            ),
            SizedBox(height: 40),
            TermsCheckbox(onChanged: termsOnPressed, value: termsAgreed),
            // Row(
            //   children: [
            //     Checkbox(
            //       checkColor: cs.onPrimary,
            //       fillColor: WidgetStateProperty.resolveWith(getColor),
            //       value: termsAgreed,
            //       onChanged: termsOnPressed,
            //     ),
            //     Text('I agree to the $tc'),
            //   ],
            // ),
            SizedBox(height: gap),
            InnButton(
              onPressed: termsAgreed ? onPressed : () {},
              buttonText: 'Sign Up',
              cs: cs,
            ),
            SizedBox(height: 50.0),
            _haveAnAccount(),
          ],
        ),
      ),
    );
  }

  /* Have an account */
  Widget _haveAnAccount() {
    return Flexible(
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          children: [
            const TextSpan(text: 'Have an account? '),
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(fontWeight: FontWeight.bold),
              // recognizer: _linkRecognizer,
              // Accessibility hint for screen readers
              semanticsLabel: 'Takes user back to the login page',
            ),
          ],
        ),
      ),
    );
  }
}
