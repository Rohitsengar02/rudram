import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DesktopShopByOccasionSection extends StatefulWidget {
  const DesktopShopByOccasionSection({super.key});

  @override
  State<DesktopShopByOccasionSection> createState() =>
      _DesktopShopByOccasionSectionState();
}

class _DesktopShopByOccasionSectionState
    extends State<DesktopShopByOccasionSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;

  final List<Map<String, String>> occasions = [
    {
      'title': 'Wedding',
      'subtitle': 'Find the perfect ensemble for special celebrations',
      'image':
          'https://images.unsplash.com/photo-1519741497674-611481863552?w=600',
    },
    {
      'title': 'Birthday Party',
      'subtitle': 'Celebrate in style with trendy outfits',
      'image':
          'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=600',
    },
    {
      'title': 'Casual Wear',
      'subtitle': 'Comfortable styles for everyday life',
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=600',
    },
    {
      'title': 'Formal Events',
      'subtitle': 'Look professional and polished',
      'image':
          'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600',
    },
    {
      'title': 'Beach Party',
      'subtitle': 'Summer vibes and breezy outfits',
      'image':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
    },
    {
      'title': 'Date Night',
      'subtitle': 'Romantic and elegant styles',
      'image':
          'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
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
                      "Shop by Occasion",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E2832),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Perfect styles for every moment",
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

          // Carousel
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: (occasions.length / 3).ceil(),
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            itemBuilder: (context, pageIndex, realIndex) {
              final startIdx = pageIndex * 3;
              final itemsInPage = <Map<String, String>>[];

              for (int i = 0; i < 3 && startIdx + i < occasions.length; i++) {
                itemsInPage.add(occasions[startIdx + i]);
              }

              return Row(
                children: itemsInPage.map((occasion) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _OccasionCard(occasion: occasion),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 24),

          // Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate((occasions.length / 3).ceil(), (index) {
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

class _OccasionCard extends StatefulWidget {
  final Map<String, String> occasion;

  const _OccasionCard({required this.occasion});

  @override
  State<_OccasionCard> createState() => _OccasionCardState();
}

class _OccasionCardState extends State<_OccasionCard> {
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
          ..translate(0.0, _isHovered ? -10.0 : 0.0)
          ..scale(_isHovered ? 1.03 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.08),
              blurRadius: _isHovered ? 25 : 15,
              offset: Offset(0, _isHovered ? 15 : 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                widget.occasion['image']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
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
                      Colors.transparent,
                      Colors.black.withOpacity(_isHovered ? 0.8 : 0.65),
                    ],
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.occasion['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.occasion['subtitle']!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (_isHovered) ...[
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE91E63),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "EXPLORE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
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
