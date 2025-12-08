import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/shared/item_card.dart';

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
        child: ColoredBox(
          color: cs.onSurface.withValues(alpha: 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TOP SECTION
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: ColoredBox(
                    color: cs.onPrimary,
                    child: Column(
                      children: [
                        // TOP HEADER
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  // Stack(
                                  //   children: [
                                  //     Positioned.fill(
                                  //   child: Container(
                                  //     width: 50.0,
                                  //     height: 50.0,
                                  //     decoration: BoxDecoration(
                                  //       color: cs.tertiaryContainer,
                                  //     ),
                                  //     child: ColoredBox(
                                  //       color: cs.onPrimary,
                                  //     ),
                                  //   ),
                                  // ),
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: cs.onSurface.withValues(
                                      alpha: 0.05,
                                    ),
                                    backgroundImage: AssetImage(
                                      'assets/img_assets/avatar.png',
                                    ),
                                  ),
                                  //   ],
                                  // ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              // Settings Icon
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  context.pushNamed('login');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: cs.onSurface.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(30),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black12,
                                    //     blurRadius: 10,
                                    //     offset: Offset(0, 4),
                                    //   ),
                                    // ],
                                  ),
                                  child: const Icon(Icons.settings, size: 25),
                                ),
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
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: cs.onSurface,
                                ),
                                filled: true,
                                fillColor: cs.onSurface.withValues(alpha: 0.05),
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
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                  child: Column(
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
                        context.pushNamed('explore');
                      }),
                      const SizedBox(height: 16),
                      _popularHotelsGrid(),
                      // const SizedBox(height: 100),
                      const SizedBox(height: 16),

                      // Rest Home
                      _sectionHeader('Restful Home', () {
                        context.pushNamed('rest');
                      }),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    final ColorScheme cs = Theme.of(context).colorScheme;

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
              Text(
                'See all',
                style: TextStyle(color: cs.primary, fontSize: 14),
              ),
              Icon(Icons.keyboard_arrow_right, size: 16, color: cs.primary),
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
          return ItemCard(
            cs: cs,
            needsInfoChip: true,
            index: index,
            cardWidth: 280.0,
            cardHeight: 250.0,
            containerMargin: 12.0,
          );
        },
      ),
    );
  }

  Widget _popularHotelsGrid() {
    ColorScheme cs = Theme.of(context).colorScheme;

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
        // return _itemCard(
        //   cs: cs,
        //   needsInfoChip: false,
        //   index: index,
        // );
        return Container(
          decoration: BoxDecoration(
            color: cs.onPrimary,
            borderRadius: BorderRadius.circular(24),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 10,
            //     offset: Offset(0, 4),
            //   ),
            // ],
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
                padding: const EdgeInsets.only(left: 12),
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
}
