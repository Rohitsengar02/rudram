import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class BubbleData {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;

  BubbleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late ScrollController _scrollController;
  late Animation<double> _avatarPositionAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Animation<Offset> _contentSlideAnimation;

  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() => _scrollOffset = _scrollController.offset);
      });

    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _avatarPositionAnimation = Tween<double>(begin: 0.35, end: 0.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _contentOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _contentSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // We rely on Theme.of(context) so no direct provider access needed here for styling
    // unless logic depends on it. background color handled by Scaffold default from Theme.

    return Scaffold(
      // Background handled by Theme (white/black)
      body: AnimatedBuilder(
        animation: _entranceController,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                top: -_scrollOffset * 0.5,
                left: 0,
                right: 0,
                height: 250,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryOrange.withValues(alpha: 0.9),
                        AppColors.primaryOrangeLight.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -50,
                        right: -50,
                        child: _circleOverlay(200, 0.1),
                      ),
                      Positioned(
                        bottom: -30,
                        left: -30,
                        child: _circleOverlay(150, 0.08),
                      ),
                    ],
                  ),
                ),
              ),
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height:
                          200 + (_avatarPositionAnimation.value * screenHeight),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Transform.translate(
                      offset: const Offset(0, -50),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).cardColor,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Hero(
                                tag: 'profile_avatar',
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: const NetworkImage(
                                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Rohit Kumar",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "rohit@example.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FadeTransition(
                      opacity: _contentOpacityAnimation,
                      child: SlideTransition(
                        position: _contentSlideAnimation,
                        child: _buildProfileContent(context),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ), // Bottom padding
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _circleOverlay(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            delay: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              _buildStatsRow(context),
              const SizedBox(height: 24),
              _buildQuickActionsCarousel(context),
              const SizedBox(height: 24),
              _buildMenuSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final opacity = (1 - (_scrollOffset / 100)).clamp(0.3, 1.0);
    return Opacity(
      opacity: opacity,
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              "12",
              "Orders",
              Icons.shopping_bag_outlined,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              "8",
              "Wishlist",
              Icons.favorite_outline,
              Colors.red,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              "₹4.2K",
              "Rewards",
              Icons.card_giftcard_outlined,
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
        ],
        border: isDark ? Border.all(color: Colors.white12) : null,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCarousel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildActionCard(
                context,
                "Edit Profile",
                Icons.edit_outlined,
                Colors.purple,
              ),
              const SizedBox(width: 12),
              _buildActionCard(
                context,
                "My Orders",
                Icons.receipt_long_outlined,
                Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildActionCard(
                context,
                "Addresses",
                Icons.location_on_outlined,
                Colors.orange,
              ),
              const SizedBox(width: 12),
              _buildActionCard(
                context,
                "Payment",
                Icons.payment_outlined,
                Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.8), color],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
        ],
        border: isDark ? Border.all(color: Colors.white12) : null,
      ),
      child: Column(
        children: [
          _buildMenuItem(
            context,
            Icons.history_outlined,
            "Order History",
            Colors.blue,
          ),
          _buildDivider(context),
          // Dark Mode Toggle
          SwitchListTile(
            title: Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            secondary: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.dark_mode_outlined,
                color: Colors.purple,
                size: 24,
              ),
            ),
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(value),
            activeTrackColor: AppColors.primaryOrange,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 4,
            ),
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            Icons.favorite_border,
            "My Wishlist",
            Colors.red,
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            Icons.notifications_outlined,
            "Notifications",
            Colors.orange,
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            Icons.settings_outlined,
            "Settings",
            Colors.grey,
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            Icons.help_outline,
            "Help & Support",
            Colors.green,
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            Icons.logout,
            "Logout",
            Colors.red,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    Color color, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDestructive
                      ? Colors.red
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, color: Theme.of(context).dividerColor),
    );
  }
}
