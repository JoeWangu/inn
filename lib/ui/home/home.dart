import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.onPrimary,
      appBar: AppBar(
        toolbarHeight: 0,
        shadowColor: cs.onPrimary,
        backgroundColor: cs.onPrimary,
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
      ),

      body: SafeArea(
        child: Column(
          children: [
            // TOP HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Row(
                children: [
                  // Avatar + Greeting
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(
                          'assets/img_assets/avatar.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.wb_sunny,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'SUNNY',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: cs.surfaceContainerHighest,
                                  fontWeight: FontWeight.w400,
                                  decorationThickness: 2.0,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Jay',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Notification Bell
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cs.onSurface.withAlpha(10),
                      borderRadius: BorderRadius.circular(30),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     blurRadius: 10,
                      //     offset: Offset(0, 4),
                      //   ),
                      // ],
                    ),
                    child: const Icon(Icons.notifications_outlined, size: 25),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Destination',
                    hintStyle: TextStyle(
                      color: cs.onSurface.withAlpha(100),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.search, color: cs.onSurface),
                    filled: true,
                    fillColor: cs.onSurface.withAlpha(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(fontSize: 16),
                  cursorHeight: 20,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // MAIN SCROLLABLE CONTENT
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: ColoredBox(
                  color: cs.onSurface.withAlpha(10),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recently Viewed
                        _sectionHeader('Recently Viewed', () {
                          context.pushNamed('app_colors');
                        }),
                        const SizedBox(height: 16),
                        _recentlyViewedList(),

                        const SizedBox(height: 32),

                        // Popular Hotels
                        _sectionHeader('Popular Hotels', () {
                          context.pushNamed('login');
                        }),
                        const SizedBox(height: 16),
                        _popularHotelsGrid(),
                        const SizedBox(
                          height: 100,
                        ), // Extra space for bottom nav
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF2B5F56),
            unselectedItemColor: Colors.grey[500],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, VoidCallback onTap) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(7)),
          onPressed: onTap,
          child: Row(
            children: [
              const Text(
                'See all',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
              Icon(Icons.keyboard_arrow_right, size: 16, color: Colors.blue),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recentlyViewedList() {
    ColorScheme cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 280,
              height: 250,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                child: Stack(
                  children: [
                    // ---------- IMAGE ----------
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/hotel${index + 1}.jpg',
                        fit: BoxFit.cover, // fills width *and* height
                        // optional: add a subtle dark overlay so white text is readable
                        // color: Colors.black.withAlpha(10),
                        // colorBlendMode: BlendMode.darken,
                      ),
                    ),

                    // ---------- BOTTOM INFO CARD ----------
                    Align(
                      alignment: Alignment.bottomCenter,
                      // child: Padding(
                      // Small padding so the inner “info card” doesn’t touch the outer edges
                      // padding: const EdgeInsets.all(2),
                      child: Card(
                        color: cs.onPrimary.withValues(alpha: 0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Aurora Luxe',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Oregon, United States',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _infoChip(Icons.king_bed_outlined, '4 Rooms'),
                                  const SizedBox(width: 12),
                                  _infoChip(
                                    Icons.bathtub_outlined,
                                    '4 Bathrooms',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _popularHotelsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Image.asset(
                  'assets/images/popular${index + 1}.jpg',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Luxury Suite ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'New York, USA',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
