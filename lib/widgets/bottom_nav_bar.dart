import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use theme colors
    final backgroundColor = isDark ? const Color(0xFF222222) : Colors.white;
    final itemColor = isDark ? Colors.white : Colors.grey[600];
    final activeColor = isDark ? Colors.white : AppColors.primaryOrange;
    final tabBgColor = AppColors.primaryOrange.withValues(
      alpha: isDark ? 0.2 : 0.1,
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Background for the notch area
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomAppBar(
        color: backgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 0, // Handled by Container shadow
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ), // Internal padding only
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Side (Home, Shop)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GNav(
                        rippleColor: Colors.grey[300]!,
                        hoverColor: Colors.grey[100]!,
                        gap: 4, // Tighter gap
                        activeColor: activeColor,
                        iconSize: 24,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: activeColor,
                          fontSize: 12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        duration: const Duration(milliseconds: 300),
                        tabBackgroundColor: tabBgColor,
                        color: itemColor,
                        tabs: const [
                          GButton(icon: Icons.home_filled, text: 'Home'),
                          GButton(
                            icon: Icons.storefront_outlined,
                            text: 'Shop',
                          ),
                        ],
                        selectedIndex: selectedIndex < 2 ? selectedIndex : -1,
                        onTabChange: onTap,
                      ),
                    ],
                  ),
                ),

                // Gap for FAB - 56 is standard FAB width + margin
                const SizedBox(width: 56),

                // Right Side (Wallet, Profile)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GNav(
                        rippleColor: Colors.grey[300]!,
                        hoverColor: Colors.grey[100]!,
                        gap: 4, // Tighter gap
                        activeColor: activeColor,
                        iconSize: 24,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: activeColor,
                          fontSize: 12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        duration: const Duration(milliseconds: 300),
                        tabBackgroundColor: tabBgColor,
                        color: itemColor,
                        tabs: const [
                          GButton(
                            icon: Icons.account_balance_wallet_outlined,
                            text: 'Wallet',
                          ),
                          GButton(icon: Icons.person_outline, text: 'Profile'),
                        ],
                        selectedIndex: selectedIndex >= 2
                            ? selectedIndex - 2
                            : -1,
                        onTabChange: (index) => onTap(index + 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
