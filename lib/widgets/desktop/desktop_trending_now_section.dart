import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../quick_view_dialog.dart';

class DesktopTrendingNowSection extends StatefulWidget {
  const DesktopTrendingNowSection({super.key});

  @override
  State<DesktopTrendingNowSection> createState() =>
      _DesktopTrendingNowSectionState();
}

class _DesktopTrendingNowSectionState extends State<DesktopTrendingNowSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;

  // Mock Data
  final List<ProductItem> products = [
    ProductItem(
      title: "Wireless Earbuds Pro",
      currentPrice: 5999.00,
      oldPrice: 9999.00,
      discount: "-40%",
      image:
          "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Smart Fitness Tracker",
      currentPrice: 3499.00,
      oldPrice: 6999.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Portable Power Bank 20000mAh",
      currentPrice: 1999.00,
      oldPrice: 3999.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Premium Phone Case",
      currentPrice: 799.00,
      oldPrice: 1499.00,
      discount: "-46%",
      image:
          "https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Bluetooth Speaker",
      currentPrice: 2999.00,
      oldPrice: 5999.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Trending Now",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E2832),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B6B), Color(0xFFE91E63)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.whatshot, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "HOT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Most popular items right now",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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

        // Carousel content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: (products.length / 5).ceil(),
            options: CarouselOptions(
              height: 420,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final int startIdx = index * 5;
              final List<ProductItem> pageProducts = [];
              for (int i = 0; i < 5 && startIdx + i < products.length; i++) {
                pageProducts.add(products[startIdx + i]);
              }

              return Row(
                children: pageProducts.map((product) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _DesktopTrendingCard(product: product),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate((products.length / 5).ceil(), (index) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(index),
              child: Container(
                width: _current == index ? 24 : 8,
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

class _DesktopTrendingCard extends StatefulWidget {
  final ProductItem product;

  const _DesktopTrendingCard({required this.product});

  @override
  State<_DesktopTrendingCard> createState() => _DesktopTrendingCardState();
}

class _DesktopTrendingCardState extends State<_DesktopTrendingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -10.0 : 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFE91E63)
                  : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.1 : 0.03),
                blurRadius: _isHovered ? 20 : 8,
                offset: Offset(0, _isHovered ? 10 : 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Stack(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      color: widget.product.bgColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        widget.product.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey[300],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Trending Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFE91E63)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Trending",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Discount Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE91E63),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.product.discount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Wishlist Icon
                  Positioned(
                    top: 50,
                    right: 12,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Icon(
                        _isHovered ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: _isHovered
                            ? const Color(0xFFE91E63)
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  // Quick View Icon (shown on hover)
                  if (_isHovered)
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () =>
                            showQuickViewDialog(context, widget.product),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                            color: Color(0xFF1E2832),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Product Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand/Vendor
                    Text(
                      "Patel Pulse V.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Product Title
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E2832),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // Price Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "₹${widget.product.currentPrice.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E2832),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "₹${widget.product.oldPrice.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
