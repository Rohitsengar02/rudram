import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class DesktopHeader extends StatelessWidget {
  const DesktopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E2832), // Dark navy blue
      child: Column(
        children: [
          // Top Bar
          _buildTopBar(),

          // Main Header
          _buildMainHeader(context),

          // Search Bar Section
          _buildSearchSection(),
        ],
      ),
    );
  }

  // Top Bar with message and contact info
  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      color: const Color(0xFF1A1F2E), // Very dark navy
      child: Row(
        children: [
          // Left side - Message and Learn More
          Row(
            children: [
              const Icon(Icons.campaign, color: Color(0xFFFFA726), size: 16),
              const SizedBox(width: 8),
              const Text(
                'good message',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Learn More',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Right side - Track Order and Phone
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white70,
                size: 16,
              ),
              const SizedBox(width: 6),
              const Text(
                'Track Order',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(width: 24),
              const Icon(Icons.phone_outlined, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              const Text(
                '+91 9087654321',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Main Header with logo, navigation, and actions
  Widget _buildMainHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      color: const Color(0xFF1E2832),
      child: Row(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'mui mat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),

          const SizedBox(width: 60),

          // Navigation Menu
          _buildNavItem('HOME', isActive: true),
          _buildNavItem('FEATURES'),
          _buildNavItem('DEAL'),
          _buildNavItem('SHOP'),
          _buildNavItem('BLOG'),

          const Spacer(),

          // Action Buttons
          Row(
            children: [
              // Wishlist
              Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Wishlist',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE91E63),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 24),

              // My Cart Button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'My Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Theme Toggle
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return IconButton(
                    icon: Icon(
                      themeProvider.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => themeProvider.toggleTheme(),
                    tooltip: themeProvider.isDarkMode
                        ? 'Light Mode'
                        : 'Dark Mode',
                  );
                },
              ),

              const SizedBox(width: 8),

              // Login
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              const SizedBox(width: 8),

              // Register Button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Color(0xFFE91E63),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Search Section
  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      color: const Color(0xFF1E2832),
      child: Row(
        children: [
          // Become Vendor Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFA726), // Orange
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: const [
                Icon(Icons.store, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'BECOME VENDOR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Search Bar
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your keyword...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE91E63), // Pink
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
