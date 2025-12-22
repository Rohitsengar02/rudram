import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/data_models.dart';
import '../quick_view_dialog.dart';

class DesktopPerfectMatchSection extends StatefulWidget {
  const DesktopPerfectMatchSection({super.key});

  @override
  State<DesktopPerfectMatchSection> createState() =>
      _DesktopPerfectMatchSectionState();
}

class _DesktopPerfectMatchSectionState
    extends State<DesktopPerfectMatchSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;

  final List<ProductItem> products = [
    ProductItem(
      title: "Minimalist Watch",
      currentPrice: 1999.00,
      oldPrice: 3999.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Designer Sunglasses",
      currentPrice: 1499.00,
      oldPrice: 2999.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Leather Wallet",
      currentPrice: 799.00,
      oldPrice: 1599.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1627123424574-724758594e93?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Premium Belt",
      currentPrice: 599.00,
      oldPrice: 1199.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1624222247344-550fb60583c2?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Classic Sneakers",
      currentPrice: 2499.00,
      oldPrice: 4999.00,
      discount: "-50%",
      image: "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade50,
            Colors.pink.shade50,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
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
                    Row(
                      children: [
                        const Text(
                          "Perfect Match for You",
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
                              colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.stars, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "AI Recommended",
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
                      "Curated specially based on your preferences",
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
            itemCount: (products.length / 5).ceil(),
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            itemBuilder: (context, pageIndex, realIndex) {
              final startIdx = pageIndex * 5;
              final itemsInPage = <ProductItem>[];

              for (int i = 0; i < 5 && startIdx + i < products.length; i++) {
                itemsInPage.add(products[startIdx + i]);
              }

              return Row(
                children: itemsInPage.map((product) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _MatchCard(product: product),
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
            children: List.generate((products.length / 5).ceil(), (index) {
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
                        ? const Color(0xFF9C27B0)
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

class _MatchCard extends StatefulWidget {
  final ProductItem product;

  const _MatchCard({required this.product});

  @override
  State<_MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<_MatchCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -10.0 : 0.0)
          ..rotateZ(_isHovered ? -0.02 : 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? const Color(0xFF9C27B0) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
              blurRadius: _isHovered ? 25 : 10,
              offset: Offset(0, _isHovered ? 12 : 5),
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
                  height: 220,
                  decoration: BoxDecoration(
                    color: widget.product.bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    child: Image.network(
                      widget.product.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Match Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.favorite, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(
                          "95% Match",
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
                // Quick View
                if (_isHovered)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => showQuickViewDialog(context, widget.product),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
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
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E2832),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "₹${widget.product.currentPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9C27B0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "₹${widget.product.oldPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 13,
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
    );
  }
}
