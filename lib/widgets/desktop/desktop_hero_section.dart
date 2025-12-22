import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DesktopHeroSection extends StatefulWidget {
  const DesktopHeroSection({super.key});

  @override
  State<DesktopHeroSection> createState() => _DesktopHeroSectionState();
}

class _DesktopHeroSectionState extends State<DesktopHeroSection> {
  int _currentBanner = 0;

  final List<String> _bannerImages = [
    'assets/images/banner_1.jpg',
    'assets/images/banner_2.jpg',
    'assets/images/banner_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5), // Light gray background
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Sidebar - All Categories
          _buildCategoriesSidebar(),

          const SizedBox(width: 20),

          // Center - Main Banner
          Expanded(flex: 2, child: _buildMainBanner()),

          const SizedBox(width: 20),

          // Right Sidebar - Promotional Cards
          _buildPromotionalCards(),
        ],
      ),
    );
  }

  Widget _buildCategoriesSidebar() {
    final categories = [
      CategoryItem('Pet Supplies', Icons.pets, Colors.orange),
      CategoryItem('Jewelry & Accessories', Icons.watch, Colors.pink),
      CategoryItem('Books & Stationery', Icons.menu_book, Colors.yellow),
      CategoryItem('Toys & Games', Icons.toys, Colors.orange),
      CategoryItem('Health & Fitness', Icons.fitness_center, Colors.red),
      CategoryItem('Beauty & Personal Care', Icons.face, Colors.blue),
      CategoryItem('Fashion & Apparel', Icons.checkroom, Colors.orange),
      CategoryItem('Gadgets', Icons.devices, Colors.purple),
      CategoryItem('Industrial Parts & Tools', Icons.build, Colors.red),
    ];

    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFFD81B60)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.apps, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  'All Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Category List
          Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: category.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            category.icon,
                            color: category.color,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade400,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainBanner() {
    return Container(
      height: 440,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 440,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() => _currentBanner = index);
              },
            ),
            items: _bannerImages.map((imageUrl) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.white),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),

          // Carousel Indicators
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_bannerImages.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentBanner == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentBanner == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalCards() {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          // Card 1 - Trending
          _buildPromoCard(
            badge: 'TRENDING',
            badgeColor: const Color(0xFFE91E63),
            title: 'COLORFUL PILLOWS',
            price: '₹299',
            imageUrl: 'assets/images/pillows.jpg',
          ),

          const SizedBox(height: 20),

          // Card 2 - Premium
          _buildPromoCard(
            badge: 'PREMIUM',
            badgeColor: const Color(0xFFE91E63),
            title: 'INTERIOR DESIGN',
            price: '₹499',
            imageUrl: 'assets/images/interior.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard({
    required String badge,
    required Color badgeColor,
    required String title,
    required String price,
    required String imageUrl,
  }) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(Icons.image, size: 40, color: Colors.white),
                  ),
                );
              },
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    'Starts at $price',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Shop Now Button
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Text(
                          'Shop now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem(this.name, this.icon, this.color);
}
