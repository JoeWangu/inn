import 'package:flutter/material.dart';
import 'package:inn/ui/utils/create_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

  void _signUp() {
    // Grab the *real* FormState from the key
    final formState = _formKey.currentState;

    if (!_termsAgreed) {
      _showAgreementMissingMessage();
      return;
    }

    if (formState == null) {
      // This should never happen if the Form is in the tree,
      // but guard against a nil reference just in case.
      debugPrint('⚠️ FormState is null maybe the Form isn\'t mounted yet.');
      return;
    }

    if (formState.validate()) {
      // All validators returned null → the form is valid
      debugPrint('✅ sign up pressed form is valid');
      // You can now read the controllers or call formState.save()
    } else {
      debugPrint('❌ not valid show errors');
    }
  }

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // final width = constraints.maxWidth;
          // final height = constraints.maxHeight;

          return SingleChildScrollView(
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
                  onPressed: _signUp,
                  cs: cs,
                  gap: 20,
                  termsAgreed: _termsAgreed,
                  termsOnPressed: _termsOnPressed,
                  buttonText: 'Sign Up',
                ),
                SizedBox(height: 40.0),
              ],
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
