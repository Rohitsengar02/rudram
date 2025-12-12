import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'luxury_home_content.dart';
import 'luxury_shop_screen.dart';
import 'luxury_concierge_screen.dart';
import 'luxury_wishlist_screen.dart';
import 'luxury_profile_screen.dart';

class LuxuryScreen extends StatefulWidget {
  const LuxuryScreen({super.key});

  @override
  State<LuxuryScreen> createState() => _LuxuryScreenState();
}

class _LuxuryScreenState extends State<LuxuryScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isLoading = true;

  late AnimationController _loadingController;
  late Animation<double> _loadingAnimation;

  List<Widget> get _screens => [
    const LuxuryHomeContent(),
    const LuxuryShopScreen(),
    const LuxuryConciergeScreen(),
    const LuxuryWishlistScreen(),
    const LuxuryProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _loadingAnimation = CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeInOut,
    );
    _loadingController.repeat(reverse: true);

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isLoading = false);
        _loadingController.stop();
      }
    });
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: FadeTransition(
            opacity: _loadingAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.diamond_outlined,
                  color: Color(0xFFD4AF37),
                  size: 64,
                ),
                const SizedBox(height: 24),
                const Text(
                  "R U D R A M",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 8,
                    fontSize: 24,
                    fontFamily: 'Playfair Display',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "L U X U R Y",
                  style: TextStyle(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
                    letterSpacing: 4,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[900],
                    color: const Color(0xFFD4AF37),
                    minHeight: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[800]!,
              hoverColor: Colors.grey[900]!,
              gap: 4, // Reduced gap for 5 items
              activeColor: const Color(0xFFD4AF37),
              iconSize: 22, // Slightly smaller icons
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color(0xFF1A1A1A),
              color: Colors.grey[600],
              tabs: const [
                GButton(icon: Icons.home_filled, text: 'Home'),
                GButton(icon: Icons.storefront, text: 'Shop'),
                GButton(icon: Icons.chat_bubble_outline, text: 'Concierge'),
                GButton(icon: Icons.favorite_border, text: 'Wishlist'),
                GButton(icon: Icons.person_outline, text: 'Profile'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _screens[_selectedIndex],
        ),
      ),
    );
  }
}
