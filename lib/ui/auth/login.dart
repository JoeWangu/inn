import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      print("Login pressed - valid!");
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // final sHeight = size.height <= 720;
    final bool isDesktop = size.width >= 800;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Critical for keyboard
      // backgroundColor: const Color(0xFF2B5F56),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(230, 43, 95, 86),
              Color.fromARGB(180, 43, 95, 86),
            ],
          ),
        ),
        child: isDesktop ? _buildDesktop() : _buildMobile(),
      ),
    );
  }

  // ========================== MOBILE ==========================
  Widget _buildMobile() {
    return SafeArea(
      child: Column(
        children: [
          // TOP SECTION
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const _HouseCircle(mobile: true),

                  // const SizedBox(height: 20),
                  // const Text(
                  //   'INN',
                  //   style: TextStyle(
                  //     color: Color(0xFFF3B633),
                  //     fontSize: 50,
                  //     fontWeight: FontWeight.w700,
                  //     letterSpacing: 4.0,
                  //   ),
                  // ),
                  // Transform.translate(
                  //   offset: const Offset(0, -10), // moves INN upward
                  // child:
                  Text(
                    'INN',
                    style: TextStyle(
                      color: Color(0xFFF3B633),
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4.0,
                    ),
                  ),
                  // ),

                  // const SizedBox(height: 4),
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: const Text(
                      'FIND YOUR PERFECT HOME',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 Input fields ABOVE the bottom sheet
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

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          /// BOTTOM ACTION SHEET
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
              // padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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

                  _buildButton('Login', true, _login),

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
    );
  }

  // ==================== DESKTOP / TABLET ====================
  Widget _buildDesktop() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _HouseCircle(mobile: false),
                const SizedBox(height: 40),
                const Text(
                  'INN',
                  style: TextStyle(
                    color: Color(0xFFEDB232),
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'FIND YOUR PERFECT HOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Card(
            margin: const EdgeInsets.all(40),
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: Form(key: _formKey, child: _buildFormFields()),
            ),
          ),
        ),
      ],
    );
  }

  // Shared form fields for desktop
  Widget _buildFormFields() {
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
        _buildButton('Login', true, _login),
        const SizedBox(height: 20),
        _buildButton('Create an account', false, () {}),
      ],
    );
  }

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
  final bool mobile;
  const _HouseCircle({required this.mobile});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final sHeight = size.height <= 670;
    // final width = MediaQuery.of(context).size.width;
    // final diameter = mobile ? width * 0.6 : 340.0;
    // final diameter = 210.0;
    final diameter = sHeight ? 150.0 : 200.0;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: diameter,
          height: diameter,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 169, 199, 195),
                Color.fromARGB(30, 76, 132, 121),
              ],
            ),
          ),
        ),
        Positioned(
          top: -diameter * 0.25,
          child: ClipOval(
            child: Image.asset(
              'assets/images/lp_house.png',
              width: diameter * 1.1,
              height: diameter * 1.2,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _login() {
//     if (_formKey.currentState!.validate()) {
//       debugPrint("Login valid!");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: const Color(0xFF2B5F56),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF2B5F56), Color(0xFF1E4D45)],
//           ),
//         ),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final width = constraints.maxWidth;
//             final height = constraints.maxHeight;
//             final isDesktop = width >= 900;

//             return isDesktop
//                 ? _DesktopLayout(onLogin: _login)
//                 : _MobileLayout(
//                     width: width,
//                     height: height,
//                     formKey: _formKey,
//                     emailController: _emailController,
//                     passwordController: _passwordController,
//                     onLogin: _login,
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }

// // ===================== MOBILE – Perfect scaling =====================
// class _MobileLayout extends StatelessWidget {
//   final double width;
//   final double height;
//   final GlobalKey<FormState> formKey;
//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   final VoidCallback onLogin;

//   const _MobileLayout({
//     required this.width,
//     required this.height,
//     required this.formKey,
//     required this.emailController,
//     required this.passwordController,
//     required this.onLogin,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Responsive values using golden ratio (looks good on every screen)
//     final circleSize = width * 0.58;           // ~58% of screen width
//     final topSpace = height * 0.12;            // 12% from top
//     final titleSize = (width * 0.18).clamp(48.0, 80.0);
//     final subtitleSize = (width * 0.04).clamp(14.0, 18.0);

//     return SafeArea(
//       child: Column(
//         children: [
//           // TOP: Logo area
//           Expanded(
//             flex: 5,
//             child: Padding(
//               padding: EdgeInsets.only(top: topSpace),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   _HouseCircle(diameter: circleSize),
//                   SizedBox(height: height * 0.04),
//                   Text('INN',
//                       style: TextStyle(
//                         color: const Color(0xFFEDB232),
//                         fontSize: titleSize,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   SizedBox(height: height * 0.015),
//                   Text('FIND YOUR PERFECT HOME',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: subtitleSize,
//                         letterSpacing: 3,
//                         fontWeight: FontWeight.w300,
//                       )),
//                 ],
//               ),
//             ),
//           ),

//           // BOTTOM: White sheet with form
//           Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
//             ),
//             padding: EdgeInsets.fromLTRB(
//               width * 0.08,   // 8% horizontal padding
//               height * 0.06,  // top padding
//               width * 0.08,
//               height * 0.05,  // bottom padding (safe for keyboard)
//             ),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildField(emailController, 'Email or Phone', Icons.person_outline),
//                   SizedBox(height: height * 0.025),
//                   _buildField(passwordController, 'Password', Icons.lock_outline, obscure: true),
//                   SizedBox(height: height * 0.015),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
//                   ),
//                   SizedBox(height: height * 0.03),
//                   _buildButton('Login', true, onLogin, width),
//                   SizedBox(height: height * 0.02),
//                   const Text('or', style: TextStyle(color: Colors.grey)),
//                   SizedBox(height: height * 0.02),
//                   _buildButton('Create an account', false, () {}, width),
//                   SizedBox(height: height * 0.03),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ===================== DESKTOP LAYOUT =====================
// class _DesktopLayout extends StatelessWidget {
//   final VoidCallback onLogin;
//   const _DesktopLayout({required this.onLogin});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _HouseCircle(diameter: 360),
//                 const SizedBox(height: 50),
//                 const Text('INN', style: TextStyle(color: Color(0xFFEDB232), fontSize: 100, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 16),
//                 const Text('FIND YOUR PERFECT HOME',
//                     style: TextStyle(color: Colors.white, fontSize: 26, letterSpacing: 5)),
//               ],
//             ),
//           ),
//         ),
//         ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 500),
//           child: Card(
//             margin: const EdgeInsets.all(60),
//             elevation: 20,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
//             child: Padding(padding: const EdgeInsets.all(50), child: _buildForm(onLogin)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ===================== REUSABLE WIDGETS =====================
// Widget _buildField(TextEditingController controller, String hint, IconData icon, {bool obscure = false}) {
//   return TextFormField(
//     controller: controller,
//     obscureText: obscure,
//     validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
//     decoration: InputDecoration(
//       prefixIcon: Icon(icon),
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.grey[100],
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
//     ),
//   );
// }

// Widget _buildButton(String text, bool filled, VoidCallback onPressed, double screenWidth) {
//   final height = screenWidth > 600 ? 60.0 : 56.0;
//   return SizedBox(
//     width: double.infinity,
//     height: height,
//     child: filled
//         ? ElevatedButton(
//             onPressed: onPressed,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2B5F56),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             ),
//             child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.white)),
//           )
//         : OutlinedButton(
//             onPressed: onPressed,
//             style: OutlinedButton.styleFrom(
//               side: const BorderSide(color: Color(0xFF2B5F56), width: 2),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             ),
//             child: Text(text, style: const TextStyle(fontSize: 18, color: Color(0xFF2B5F56))),
//           ),
//   );
// }

// class _HouseCircle extends StatelessWidget {
//   final double diameter;
//   const _HouseCircle({required this.diameter});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: diameter,
//           height: diameter,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color.fromARGB(255, 169, 199, 195), Color.fromARGB(30, 76, 132, 121)],
//             ),
//           ),
//         ),
//         Positioned(
//           top: -diameter * 0.38,
//           child: ClipOval(
//             child: Image.asset(
//               'assets/images/lp_house.png',
//               width: diameter * 1.15,
//               height: diameter * 1.35,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Desktop form (shared)
// Widget _buildForm(VoidCallback onLogin) {
//   final emailCtrl = TextEditingController();
//   final passCtrl = TextEditingController();
//   final key = GlobalKey<FormState>();

//   return Form(
//     key: key,
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _buildField(emailCtrl, 'Email or Phone', Icons.person_outline),
//         const SizedBox(height: 24),
//         _buildField(passCtrl, 'Password', Icons.lock_outline, obscure: true),
//         const SizedBox(height: 16),
//         Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Forgot Password?'))),
//         const SizedBox(height: 32),
//         _buildButton('Login', true, () {
//           if (key.currentState!.validate()) onLogin();
//         }, 500),
//         const SizedBox(height: 24),
//         _buildButton('Create an account', false, () {}, 500),
//       ],
//     ),
//   );
// }
