import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/core/errors/error_handler.dart';
import 'package:inn/presentation/shared/create_form.dart';
import 'package:inn/presentation/controllers/auth_controllers/sign_up_controller.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password1Controller = TextEditingController();
  bool _termsAgreed = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password1Controller.dispose();
    super.dispose();
  }

  void _termsOnPressed(bool? newValue) => setState(() {
    _termsAgreed = newValue!;
    // if (_termsAgreed) {
    //   // TODOs: Here goes your functionality that remembers the user.
    // } else {
    //   // TODOs: Forget the user
    // }
  });

  void _showAgreementMissingMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'You must agree to the Terms & Conditions before signing up.',
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final signUpState = ref.watch(signUpControllerProvider);
    ref.listen<AsyncValue<void>>(signUpControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Signup successful! Welcome aboard.',
                style: TextStyle(color: cs.onPrimary),
              ),
              backgroundColor: cs.primary,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );

          context.goNamed('home');
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(getReadableError(error)),
              backgroundColor: cs.error,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(200),
        toolbarHeight: 0,
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
      ),
      // backgroundColor: cs.primary.withAlpha(200),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // final width = constraints.maxWidth;
          // final height = constraints.maxHeight;

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _title(cs: cs),
                  SizedBox(height: 30),
                  CreateForm(
                    formKey: _formKey,
                    usernameController: _usernameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    password1Controller: _password1Controller,
                    cs: cs,
                    gap: 20,
                    termsAgreed: _termsAgreed,
                    termsOnPressed: _termsOnPressed,
                    buttonText: 'Sign Up',
                    isLoading: signUpState.isLoading,
                    obscurePassword: _obscurePassword,
                    obscureConfirm: _obscureConfirmPassword,
                    onToggleObscure: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    onToggleObscureConfirm: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    onPressed: () {
                      final formState = _formKey.currentState;

                      if (!_termsAgreed) {
                        _showAgreementMissingMessage();
                        return;
                      }
                      if (formState == null || !formState.validate()) {
                        return;
                      }
                      formState.save();

                      ref
                          .read(signUpControllerProvider.notifier)
                          .signUp(
                            name: _usernameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _password1Controller.text,
                          );
                    },
                  ),
                  SizedBox(height: 40.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _title({required ColorScheme cs}) {
    return Container(
      // height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.primary.withAlpha(200),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Let\'s',
              // textAlign: TextAlign.start,
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 40.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.0,
                height: 1.0,
              ),
            ),
            Text(
              'Create',
              // textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                height: 1.0,
              ),
            ),
            Text(
              'Your',
              // textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                height: 1.0,
              ),
            ),
            Text(
              'Account',
              // textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
