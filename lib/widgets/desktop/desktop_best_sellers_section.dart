import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../quick_view_dialog.dart';

class DesktopBestSellersSection extends StatefulWidget {
  const DesktopBestSellersSection({super.key});

  @override
  State<DesktopBestSellersSection> createState() =>
      _DesktopBestSellersSectionState();
}

class _DesktopBestSellersSectionState extends State<DesktopBestSellersSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;

  // Mock Data
  final List<ProductItem> products = [
    ProductItem(
      title: "Premium Leather Jacket",
      currentPrice: 12999.00,
      oldPrice: 19999.00,
      discount: "-35%",
      image: "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Designer Sunglasses",
      currentPrice: 3999.00,
      oldPrice: 8999.00,
      discount: "-55%",
      image:
          "https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Canvas Backpack",
      currentPrice: 2499.00,
      oldPrice: 4999.00,
      discount: "-50%",
      image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Vintage Wristwatch",
      currentPrice: 8999.00,
      oldPrice: 15999.00,
      discount: "-43%",
      image:
          "https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Casual Sneakers",
      currentPrice: 4499.00,
      oldPrice: 7999.00,
      discount: "-43%",
      image: "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500",
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
                  const Text(
                    "Best Sellers",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E2832),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Top rated products by our customers",
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
            itemCount: (products.length / 4).ceil(),
            options: CarouselOptions(
              height: 480,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final int startIdx = index * 4;
              final List<ProductItem> pageProducts = [];
              for (int i = 0; i < 4 && startIdx + i < products.length; i++) {
                pageProducts.add(products[startIdx + i]);
              }

              return Row(
                children: pageProducts.map((product) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _DesktopBestSellerCard(product: product),
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
          children: List.generate((products.length / 4).ceil(), (index) {
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

class _DesktopBestSellerCard extends StatefulWidget {
  final ProductItem product;

  const _DesktopBestSellerCard({required this.product});

  @override
  State<_DesktopBestSellerCard> createState() => _DesktopBestSellerCardState();
}

class _DesktopBestSellerCardState extends State<_DesktopBestSellerCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..rotateZ(_isHovered ? -0.01 : 0)
          ..translate(0.0, _isHovered ? -8.0 : 0.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                _isHovered ? const Color(0xFFFFF3F8) : Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFE91E63)
                  : Colors.grey.shade200,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
                blurRadius: _isHovered ? 30 : 10,
                offset: Offset(0, _isHovered ? 15 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section with overlay
              Stack(
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      color: widget.product.bgColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            widget.product.image,
                            width: double.infinity,
                            height: 280,
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
                          // Gradient overlay on hover
                          if (_isHovered)
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Best Seller Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4CAF50).withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.star, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "Best Seller",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
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
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE91E63),
                        borderRadius: BorderRadius.circular(8),
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

                  // Hover actions
                  if (_isHovered)
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Row(
                        children: [
                          _buildActionButton(
                            icon: Icons.favorite_border,
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _buildActionButton(
                            icon: Icons.remove_red_eye_outlined,
                            onTap: () =>
                                showQuickViewDialog(context, widget.product),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rating stars
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            size: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Product Title
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2832),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const Spacer(),

                      // Price Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "₹${widget.product.currentPrice.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE91E63),
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

                      const SizedBox(height: 12),

                      // Add to Cart Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isHovered
                                ? const Color(0xFFE91E63)
                                : const Color(0xFF1E2832),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            _isHovered ? "Buy Now" : "Add to Cart",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
          ],
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF1E2832)),
      ),
    );
  }
}
