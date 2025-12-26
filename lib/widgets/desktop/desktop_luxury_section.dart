import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../screens/desktop/desktop_luxury_products_page.dart';

class DesktopLuxurySection extends StatefulWidget {
  const DesktopLuxurySection({super.key});

  @override
  State<DesktopLuxurySection> createState() => _DesktopLuxurySectionState();
}

class _DesktopLuxurySectionState extends State<DesktopLuxurySection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          // Left side - Interactive Image
          Expanded(
            flex: 6,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutQuart,
                height: 650,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isHovered ? 0.25 : 0.1),
                      blurRadius: _isHovered ? 40 : 20,
                      offset: Offset(0, _isHovered ? 20 : 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Main Image
                      AnimatedScale(
                        duration: const Duration(milliseconds: 1000),
                        scale: _isHovered ? 1.05 : 1.0,
                        child: Image.network(
                          'https://images.weserv.nl/?url=https://i.pinimg.com/736x/54/26/f3/5426f37ee3738c45aa2e07091c6ea709.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, size: 80),
                              ),
                        ),
                      ),

                      // Elegant Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      // Rare Badge
                      Positioned(
                        top: 30,
                        left: 30,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Text(
                            "RARE COLLECTION",
                            style: TextStyle(
                              color: Color(0xFF1E2832),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 80),

          // Right side - Content
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'THE LUXURY EXPERIENCE',
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Bridal Heritage\nmeets Modern Fine Art',
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E2832),
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Elevate your presence with our most exclusive masterpiece collection. Each piece is handcrafted over hundreds of hours by master artisans, using only the finest ethically sourced diamonds and 22K gold.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    height: 1.7,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 50),

                // Feature List
                _buildLuxuryFeature(
                  Icons.auto_awesome,
                  "Master Artisan Crafted",
                ),
                const SizedBox(height: 20),
                _buildLuxuryFeature(
                  Icons.verified_user,
                  "Lifetime Authenticity Guarantee",
                ),
                const SizedBox(height: 20),
                _buildLuxuryFeature(
                  Icons.diamond,
                  "Certified Pre-Selected Gems",
                ),

                const SizedBox(height: 60),

                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DesktopLuxuryProductsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2832),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45,
                          vertical: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'EXPLORE ELITE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Text(
                            'BOOK PRIVATE VIEWING',
                            style: TextStyle(
                              color: Color(0xFF1E2832),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF1E2832),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLuxuryFeature(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryOrange, size: 20),
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E2832),
          ),
        ),
      ],
    );
  }
}
