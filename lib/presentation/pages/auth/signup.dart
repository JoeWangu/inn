import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/data/models/user.dart';
import 'package:inn/presentation/shared/create_form.dart';
import 'package:inn/presentation/pages/auth/signup_viewmodel.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password1Controller = TextEditingController();
  bool _termsAgreed = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password1Controller.dispose();
    super.dispose();
  }

  /*   // void _signUp() {
  //   // Grab the *real* FormState from the key
  //   final formState = _formKey.currentState;

  //   if (!_termsAgreed) {
  //     _showAgreementMissingMessage();
  //     return;
  //   }

  //   if (formState == null) {
  //     // This should never happen if the Form is in the tree,
  //     // but guard against a nil reference just in case.
  //     debugPrint('⚠️ FormState is null maybe the Form isn\'t mounted yet.');
  //     return;
  //   }

  //   if (formState.validate()) {
  //     // All validators returned null → the form is valid
  //     debugPrint('✅ sign up pressed form is valid');
  //     // You can now read the controllers or call formState.save()
  //   } else {
  //     debugPrint('❌ not valid show errors');
  //   }
  // } */

  void _termsOnPressed(bool? newValue) => setState(() {
    _termsAgreed = newValue!;

    if (_termsAgreed) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(200),
        // title: const Text('INN'),
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
                    fullNameController: _fullNameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    password1Controller: _password1Controller,
                    // onPressed: _signUp,
                    onPressed: () async {
                      final formState = _formKey.currentState;

                      if (!_termsAgreed) {
                        _showAgreementMissingMessage();
                        return;
                      }

                      if (formState == null) {
                        debugPrint(
                          '⚠️ FormState is null maybe the Form isn\'t mounted yet.',
                        );
                        return;
                      }

                      if (!formState.validate()) {
                        debugPrint('❌ Form validation failed – show errors');
                        return;
                      }
                      formState.save();
                      final user = User(
                        fullName: _fullNameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _password1Controller.text,
                      );

                      // Store context BEFORE the await otherwise the warning
                      // never goes away
                      final navigator = GoRouter.of(context);
                      final messenger = ScaffoldMessenger.of(context);

                      final bool ok = await ref
                          .read(signupViewmodelProvider.notifier)
                          .signupUser(user);

                      if (!mounted) return;

                      if (ok) {
                        navigator.pushReplacementNamed('home');
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(content: Text('Signup failed')),
                        );
                      }
                    },
                    cs: cs,
                    gap: 20,
                    termsAgreed: _termsAgreed,
                    termsOnPressed: _termsOnPressed,
                    buttonText: 'Sign Up',
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
