import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  final List<String> _images = [
    "assets/onboarding/left.jpg",
    "assets/onboarding/main.jpg",
    "assets/onboarding/right.jpg",
  ];

  final List<String> _titles = [
    "Find beautiful stays",
    "Book your next trip",
    "Explore the world",
  ];

  final List<String> _subtitles = [
    "Discover unique homes and apartments.",
    "Easily plan and organize your journey.",
    "World is waiting for you to explore.",
  ];

  void _nextPage() {
    if (currentPage == _images.length - 1) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    final prefs = SharedPreferencesAsync();
    await prefs.setBool('seen_onboarding', true);
    if (mounted) {
      context.goNamed('login');
    }
  }

  Future<bool> _onWillPop() async {
    if (currentPage == 0) {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () => context.pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text(
                    "Exit",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }
    _previousPage();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: cs.onPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // if (currentPage > 0) ...[
                  // IconButton(
                  //   onPressed: _previousPage,
                  //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  //   color: Colors.black87,
                  //   highlightColor: cs.onSurface.withValues(alpha: 0.5),
                  // ),
                  ElevatedButton(
                    onPressed: _onWillPop,
                    // style: ButtonStyle(
                    //   shape: WidgetStateProperty.all(CircleBorder()),
                    // ),
                    child: const Icon(Icons.arrow_back),
                  ),

                  // ] else ...[
                  //   IconButton(
                  //     onPressed: _onWillPop,
                  //     icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  //     color: Colors.black87,
                  //   ),
                  // ],
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF0066FF),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 2),

              SizedBox(
                height: size.height * 0.30,
                width: size.width * 0.60,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) => setState(() => currentPage = value),
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        _images[index],
                        width: 220,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

              const Spacer(flex: 3),

              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _images.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == currentPage ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: i == currentPage
                          ? const Color(0xFF0066FF)
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Title
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _titles[currentPage],
                  key: ValueKey(currentPage),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  key: ValueKey('sub_$currentPage'),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _subtitles[currentPage],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 4),

              // Bottom buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  children: [
                    // Previous button
                    if (currentPage > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _previousPage,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            side: const BorderSide(color: Color(0xFF0066FF)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Previous",
                            style: TextStyle(
                              color: Color(0xFF0066FF),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),

                    if (currentPage > 0) const SizedBox(width: 12),

                    // Next / Continue button
                    Expanded(
                      flex: currentPage == 0 ? 2 : 1,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0066FF),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          currentPage == _images.length - 1
                              ? "Get Started"
                              : "Next",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
