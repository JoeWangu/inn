import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/core/errors/error_handler.dart';
import 'package:inn/presentation/controllers/auth_controllers/login_controller.dart';
// import 'package:inn/presentation/pages/auth/login_viewmodel.dart';
import 'package:inn/presentation/shared/buttons.dart';

/* class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ColorScheme cs = Theme.of(context).colorScheme;

    final size = MediaQuery.sizeOf(context);
    final bool isDesktop = size.width >= 800;
    final double viewportHeight =
        MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // cs.primary.withAlpha(200),
              // cs.primary.withAlpha(170),
              Color.fromARGB(200, 43, 95, 86),
              Color.fromARGB(240, 43, 95, 86),
            ],
          ),
        ),
        child: isDesktop
            ? _buildDesktop(login: () {})
            : _buildMobile(
                BoxConstraints(minHeight: viewportHeight),
                login: () async {
                  final formState = _formKey.currentState;
                  if (formState == null) return;
                  if (!formState.validate()) return;
                  formState.save();
                  final navigator = GoRouter.of(context);
                  final messenger = ScaffoldMessenger.of(context);
                  final bool success = await ref
                      .read(loginViewmodelProvider.notifier)
                      .loginUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                      );
                  if (!mounted) return;
                  if (success) {
                    navigator.pushReplacementNamed('home');
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('no such user')),
                    );
                  }
                },
              ),
      ),
    );
  }

  // ========================== MOBILE ==========================
  Widget _buildMobile(
    BoxConstraints constraints, {
    required VoidCallback login,
  }) {
    // Get screen dimensions
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    final screenHeight = size.height;

    // Base diameter: 55–65% of screen width (looks big & balanced)
    // We clamp it so it never gets too small or too big
    final double baseDiameter = (screenWidth * 0.62).clamp(180.0, 360.0);

    // Adjust slightly based on height (for very short screens like iPhone SE)
    final bool isShortScreen = screenHeight < 700;
    final double diameter = isShortScreen ? baseDiameter * 0.85 : baseDiameter;

    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    // const _HouseCircle(mobile: true),
                    _HouseCircle(diameter: diameter),

                    Text(
                      'INN',
                      style: TextStyle(
                        color: Color(0xFFF3B633),
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4.0,
                      ),
                    ),

                    // const SizedBox(height: 4),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: const Text(
                        'FIND YOUR PERFECT HOME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // The form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: _emailController,
                            hint: 'Email or Phone',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 15),

                          _buildTextField(
                            controller: _passwordController,
                            hint: 'Password',
                            icon: Icons.lock_outline,
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // BOTTOM ACTION SHEET
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          print('object');
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),

                      const SizedBox(height: 10),

                      _buildButton('Login', true, login),

                      const SizedBox(height: 5),

                      const Text('or', style: TextStyle(color: Colors.grey)),

                      const SizedBox(height: 5),

                      _buildButton('Create an account', false, () {
                        context.pushNamed('signup');
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== DESKTOP / TABLET ====================
  Widget _buildDesktop({required VoidCallback login}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        // Dynamic values based on screen size
        final double leftPanelWidth = screenWidth * 0.55; // 55% for art
        // final double formMaxWidth = 520.0;
        final double circleSize = (screenWidth * 0.28).clamp(280.0, 420.0);
        final double titleFontSize = (screenWidth * 0.07).clamp(70.0, 110.0);
        final double subtitleFontSize = (screenWidth * 0.015).clamp(18.0, 28.0);

        return Row(
          children: [
            // LEFT: Hero illustration + title (scales beautifully)
            SizedBox(
              width: leftPanelWidth,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _HouseCircle(diameter: circleSize),
                      SizedBox(height: screenHeight * 0.06),
                      Text(
                        'INN',
                        style: TextStyle(
                          color: const Color(0xFFEDB232),
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'FIND YOUR PERFECT HOME',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: subtitleFontSize,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // RIGHT: Login form card (never overflows)
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.1,
                    ),
                    elevation: 20,
                    shadowColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(48, 56, 48, 48),
                      child: Form(
                        key: _formKey,
                        child: _buildFormFields(
                          login: login,
                        ), // your existing form
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Shared form fields for desktop
  Widget _buildFormFields({required VoidCallback login}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(
          controller: _emailController,
          hint: 'Email',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _passwordController,
          hint: 'Password',
          icon: Icons.lock_outline,
          isPassword: true,
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?'),
          ),
        ),
        const SizedBox(height: 30),
        _buildButton('Login', true, login),
        const SizedBox(height: 20),
        _buildButton('Create an account', false, () {
          context.pushNamed('signup');
        }),
      ],
    );
  }

  // Shared form fields for mobile
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: (v) => v!.trim().isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF2B5F56), width: 1.4),
        ),
      ),
    );
  }

  // Shared buttons
  Widget _buildButton(String text, bool filled, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: filled
          ? ElevatedButton(
              onPressed: onPressed,
              style:
                  ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      return null; // use Ink + gradient
                    }),
                    shadowColor: WidgetStateProperty.all(Colors.black26),
                    elevation: WidgetStateProperty.all(6),
                  ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E7166), Color(0xFF1E5A50)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.grey.shade200,
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
            ),
    );
  }
}

// Responsive house circle
class _HouseCircle extends StatelessWidget {
  final double diameter;
  const _HouseCircle({required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Gradient circle
        Container(
          width: diameter * 1.3,
          height: diameter * 1.1,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Color.fromARGB(255, 109, 184, 174),
                // Color.fromARGB(30, 76, 132, 121),
                Color.fromARGB(160, 109, 243, 221),
                Color.fromARGB(0, 43, 95, 86),
              ],
            ),
          ),
        ),
        // House image popping out
        Positioned(
          top: -diameter * 0.28,
          child: ClipOval(
            child: Image.asset(
              'assets/img_assets/lp_house.png',
              width: diameter * 1.15,
              height: diameter * 1.4,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
 */

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // IMPROVEMENT: Password Visibility Toggle
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. WATCH STATE (For loading spinner)
    final ColorScheme cs = Theme.of(context).colorScheme;
    final loginState = ref.watch(loginControllerProvider);
    final isLoading = loginState.isLoading;

    // 2. LISTEN FOR RESULTS (Success/Error)
    ref.listen<AsyncValue<void>>(loginControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Login successful! Welcome',
                style: TextStyle(color: cs.onPrimary),
              ),
              backgroundColor: cs.primary,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
          // Success! Go home.
          context.goNamed('home');
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(getReadableError(error)),
              backgroundColor: cs.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

    final size = MediaQuery.sizeOf(context);
    final bool isDesktop = size.width >= 800;
    final double viewportHeight =
        MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(200, 43, 95, 86),
              Color.fromARGB(240, 43, 95, 86),
            ],
          ),
        ),
        child: isDesktop
            ? _buildDesktop(isLoading: isLoading, cs: cs)
            : _buildMobile(
                BoxConstraints(minHeight: viewportHeight),
                isLoading: isLoading,
                cs: cs,
              ),
      ),
    );
  }

  // --- LOGIC HELPER ---
  void _onLoginPressed() {
    // Close keyboard
    FocusScope.of(context).unfocus();

    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;

    formState.save();

    // Trigger Controller
    ref
        .read(loginControllerProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  // ========================== MOBILE ==========================
  Widget _buildMobile(
    BoxConstraints constraints, {
    required bool isLoading,
    required ColorScheme cs,
  }) {
    final size = MediaQuery.sizeOf(context);
    // ... (Your existing layout math logic) ...
    final double baseDiameter = (size.width * 0.62).clamp(180.0, 360.0);
    final bool isShortScreen = size.height < 700;
    final double diameter = isShortScreen ? baseDiameter * 0.85 : baseDiameter;

    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    _HouseCircle(diameter: diameter),
                    const Text(
                      'INN',
                      style: TextStyle(
                        color: Color(0xFFF3B633),
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4.0,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: const Text(
                        'FIND YOUR PERFECT HOME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // IMPROVEMENT: AbsorbPointer prevents editing while loading
                    AbsorbPointer(
                      absorbing: isLoading,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _emailController,
                              hint: 'Email or Phone',
                              icon: Icons.person_outline,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              controller: _passwordController,
                              hint: 'Password',
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // BOTTOM SHEET
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                  child: Column(
                    children: [
                      TextButton(
                        // Disable when loading
                        onPressed: isLoading ? null : () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // IMPROVEMENT: Reused your InnButton
                      InnButton(
                        onPressed: _onLoginPressed,
                        buttonText: 'Login',
                        cs: cs,
                        isLoading: isLoading, // Shows spinner automatically
                      ),

                      const SizedBox(height: 5),
                      const Text('or', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 5),

                      // Reuse InnButton (Outline variant)
                      InnButton(
                        onPressed: () => context.pushNamed('signup'),
                        buttonText: 'Create an account',
                        cs: cs,
                        filled: false,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== DESKTOP / TABLET ====================
  Widget _buildDesktop({required bool isLoading, required ColorScheme cs}) {
    // ... (Your LayoutBuilder logic) ...
    return LayoutBuilder(
      builder: (context, constraints) {
        // ... (Keep your math variables) ...
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;
        final double leftPanelWidth = screenWidth * 0.55;
        final double circleSize = (screenWidth * 0.28).clamp(280.0, 420.0);
        final double titleFontSize = (screenWidth * 0.07).clamp(70.0, 110.0);
        final double subtitleFontSize = (screenWidth * 0.015).clamp(18.0, 28.0);

        return Row(
          children: [
            SizedBox(
              width: leftPanelWidth,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _HouseCircle(diameter: circleSize),
                      SizedBox(height: screenHeight * 0.06),
                      Text(
                        'INN',
                        style: TextStyle(
                          color: const Color(0xFFEDB232),
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'FIND YOUR PERFECT HOME',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: subtitleFontSize,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.1,
                    ),
                    elevation: 20,
                    shadowColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(48, 56, 48, 48),
                      child: AbsorbPointer(
                        absorbing: isLoading, // Freeze desktop form too
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildTextField(
                                controller: _emailController,
                                hint: 'Email',
                                icon: Icons.person_outline,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: _passwordController,
                                hint: 'Password',
                                icon: Icons.lock_outline,
                                isPassword: true,
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: isLoading ? null : () {},
                                  child: const Text('Forgot Password?'),
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Desktop Buttons
                              InnButton(
                                onPressed: _onLoginPressed,
                                buttonText: 'Login',
                                cs: cs,
                                isLoading: isLoading,
                              ),
                              const SizedBox(height: 20),
                              InnButton(
                                onPressed: () => context.pushNamed('signup'),
                                buttonText: 'Create an account',
                                cs: cs,
                                filled: false,
                                isLoading: isLoading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- REFINED TEXT FIELD WITH TOGGLE ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      // IMPROVEMENT: Toggle logic
      obscureText: isPassword ? _obscurePassword : false,
      validator: (v) => v!.trim().isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),

        // IMPROVEMENT: Add the Eye Icon
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,

        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF2B5F56), width: 1.4),
        ),
      ),
    );
  }
}

// Responsive house circle
class _HouseCircle extends StatelessWidget {
  final double diameter;
  const _HouseCircle({required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Gradient circle
        Container(
          width: diameter * 1.3,
          height: diameter * 1.1,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Color.fromARGB(255, 109, 184, 174),
                // Color.fromARGB(30, 76, 132, 121),
                Color.fromARGB(160, 109, 243, 221),
                Color.fromARGB(0, 43, 95, 86),
              ],
            ),
          ),
        ),
        // House image popping out
        Positioned(
          top: -diameter * 0.28,
          child: ClipOval(
            child: Image.asset(
              'assets/img_assets/lp_house.png',
              width: diameter * 1.15,
              height: diameter * 1.4,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
