import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../quick_view_dialog.dart';

class DesktopFlashSaleSection extends StatefulWidget {
  const DesktopFlashSaleSection({super.key});

  @override
  State<DesktopFlashSaleSection> createState() =>
      _DesktopFlashSaleSectionState();
}

class _DesktopFlashSaleSectionState extends State<DesktopFlashSaleSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;

  // Mock Data matching the style of the screenshot
  final List<ProductItem> products = [
    ProductItem(
      title: "Black Color Laptop",
      currentPrice: 70000.00,
      oldPrice: 116900.00,
      discount: "-32%",
      image:
          "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500",
      bgColor: const Color(0xFFF0F0F0),
    ),
    ProductItem(
      title: "Aerofit Spin Bike AF-780",
      currentPrice: 42999.00,
      oldPrice: 71808.33,
      discount: "-25%",
      image:
          "https://images.unsplash.com/photo-1517649763962-0c623066013b?w=500",
      bgColor: const Color(0xFFF0F0F0),
    ),
    ProductItem(
      title: "Smart Watch Series 7",
      currentPrice: 35000.00,
      oldPrice: 45000.00,
      discount: "-22%",
      image:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500",
      bgColor: const Color(0xFFF0F0F0),
    ),
    ProductItem(
      title: "Gaming Headphones",
      currentPrice: 15000.00,
      oldPrice: 20000.00,
      discount: "-25%",
      image:
          "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500",
      bgColor: const Color(0xFFF0F0F0),
    ),
    ProductItem(
      title: "DSLR Camera",
      currentPrice: 55000.00,
      oldPrice: 65000.00,
      discount: "-15%",
      image:
          "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=500",
      bgColor: const Color(0xFFF0F0F0),
    ),
    ProductItem(
      title: "Wireless Earbuds",
      currentPrice: 2500.00,
      oldPrice: 5000.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500",
      bgColor: const Color(0xFFF0F0F0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Daily Deals",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E2832),
                ),
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
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: (products.length / 3).ceil(),
          options: CarouselOptions(
            height: 320, // Adjusted to fit larger image with tighter card
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final int first = index * 3;
            final int second = first + 1;
            final int third = first + 2;
            return Row(
              children: [
                Expanded(
                  child: _DesktopFlashSaleCard(
                    product: products[first],
                    available: 50,
                    sold: 14,
                  ),
                ),
                const SizedBox(width: 20),
                if (second < products.length)
                  Expanded(
                    child: _DesktopFlashSaleCard(
                      product: products[second],
                      available: 56,
                      sold: 11,
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
                const SizedBox(width: 20),
                if (third < products.length)
                  Expanded(
                    child: _DesktopFlashSaleCard(
                      product: products[third],
                      available: 32,
                      sold: 20,
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            );
          },
        ),

        const SizedBox(height: 20),

        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate((products.length / 3).ceil(), (index) {
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

class _DesktopFlashSaleCard extends StatefulWidget {
  final ProductItem product;
  final int available;
  final int sold;

  const _DesktopFlashSaleCard({
    required this.product,
    required this.available,
    required this.sold,
  });

  @override
  State<_DesktopFlashSaleCard> createState() => _DesktopFlashSaleCardState();
}

class _DesktopFlashSaleCardState extends State<_DesktopFlashSaleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.08 : 0.02),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 2),
            ),
          ],
        ),
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          bottom: 10,
          left: 10,
        ),
        child: Row(
          children: [
            // Left: Image Section (40% width)
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    height: 300, // Increased height for larger image
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.product.image.startsWith('http')
                            ? widget.product.image
                            : 'https://via.placeholder.com/300?text=${widget.product.title}',
                        fit: BoxFit.cover, // Full height and width
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
                  // Discount Badge (Top Left)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE91E63),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.product.discount, // e.g. "--68%"
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Wishlist Icon (Top Right)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // Right: Details Section (60% width)
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700, // Bold
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
                        "₹${widget.product.currentPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE91E63), // Pink price
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "₹${widget.product.oldPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    "They key to have more time is to them well, but we love them anyway. Premium quality guaranteed.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 20),

                  // Availability Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Available
                      Row(
                        children: [
                          Text(
                            'Available ',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${widget.available}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E2832),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Sold
                      Row(
                        children: [
                          Text(
                            'Sold ',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFE91E63,
                              ).withOpacity(0.1), // Light pink bg
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${widget.sold}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE91E63),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: widget.sold / (widget.available + widget.sold),
                      backgroundColor: Colors.grey.shade100,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFE91E63),
                      ),
                      minHeight: 8, // Thicker bar like reference
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      // Eye Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(
                          Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),

                      const Spacer(),

                      // Quick View Button
                      IconButton(
                        onPressed: () =>
                            showQuickViewDialog(context, widget.product),
                        icon: const Icon(Icons.remove_red_eye_outlined),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          foregroundColor: const Color(0xFF1E2832),
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Add to Cart Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE91E63),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          minimumSize: const Size(120, 45),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
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
