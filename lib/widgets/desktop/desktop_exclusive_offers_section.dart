import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DesktopExclusiveOffersSection extends StatefulWidget {
  const DesktopExclusiveOffersSection({super.key});

  @override
  State<DesktopExclusiveOffersSection> createState() =>
      _DesktopExclusiveOffersSectionState();
}

class _DesktopExclusiveOffersSectionState
    extends State<DesktopExclusiveOffersSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;

  // Category data
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Fashion',
      'subtitle': 'Up to 70% Off',
      'icon': Icons.checkroom,
      'color': const Color(0xFFE91E63),
      'image':
          'https://images.unsplash.com/photo-1445205170230-053b83016050?w=400',
    },
    {
      'title': 'Electronics',
      'subtitle': 'Special Deals',
      'icon': Icons.devices,
      'color': const Color(0xFF2196F3),
      'image':
          'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=400',
    },
  ];

  // Carousel offers
  final List<Map<String, String>> offers = [
    {
      'title': 'MEGA SALE',
      'subtitle': 'Up to 80% Off on Electronics',
      'image':
          'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800',
    },
    {
      'title': 'FASHION WEEK',
      'subtitle': 'Exclusive Designer Collection',
      'image':
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800',
    },
    {
      'title': 'HOME DECOR',
      'subtitle': 'Transform Your Space',
      'image':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Exclusive Offers",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E2832),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Limited time deals you don't want to miss",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildNavButton(
                      icon: Icons.chevron_left,
                      onTap: () => _carouselController.previousPage(),
                    ),
                    const SizedBox(width: 10),
                    _buildNavButton(
                      icon: Icons.chevron_right,
                      onTap: () => _carouselController.nextPage(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Content: Grid on Left, Carousel on Right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: 4 Grid Categories
              Expanded(flex: 2, child: _buildCategoriesGrid()),

              const SizedBox(width: 20),

              // Right: Carousel
              Expanded(flex: 3, child: _buildOffersCarousel()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return SizedBox(
      height: 480,
      child: Column(
        children: [
          Expanded(child: _buildCategoryCard(categories[0])),
          const SizedBox(height: 16),
          Expanded(child: _buildCategoryCard(categories[1])),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return _CategoryCard(category: category);
  }

  Widget _buildOffersCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: offers.length,
          options: CarouselOptions(
            height: 480,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return _buildOfferCard(offers[index]);
          },
        ),

        const SizedBox(height: 20),

        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(offers.length, (index) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _current == index ? 32 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _current == index
                      ? const Color(0xFFE91E63)
                      : Colors.grey.shade300,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildOfferCard(Map<String, String> offer) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.network(
              offer['image']!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.image, size: 60, color: Colors.grey),
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
            Positioned(
              bottom: 40,
              left: 40,
              right: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE91E63),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "LIMITED TIME",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    offer['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    offer['subtitle']!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1E2832),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "SHOP NOW",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
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

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Icon(icon, color: const Color(0xFF1E2832), size: 20),
      ),
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final Map<String, dynamic> category;

  const _CategoryCard({required this.category});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0)
          ..scale(_isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 10 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                widget.category['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: widget.category['color'].withOpacity(0.1),
                  );
                },
              ),

              // Gradient Overlay
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(_isHovered ? 0.4 : 0.3),
                      widget.category['color'].withOpacity(
                        _isHovered ? 0.9 : 0.8,
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedScale(
                      scale: _isHovered ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        widget.category['icon'],
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.category['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.category['subtitle'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Tap Effect
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.white.withOpacity(0.2),
                  highlightColor: Colors.white.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
