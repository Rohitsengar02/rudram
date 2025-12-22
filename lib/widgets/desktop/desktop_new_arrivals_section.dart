import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../quick_view_dialog.dart';

class DesktopNewArrivalsSection extends StatefulWidget {
  const DesktopNewArrivalsSection({super.key});

  @override
  State<DesktopNewArrivalsSection> createState() =>
      _DesktopNewArrivalsSectionState();
}

class _DesktopNewArrivalsSectionState extends State<DesktopNewArrivalsSection>
    with SingleTickerProviderStateMixin {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Mock Data
  final List<ProductItem> products = [
    ProductItem(
      title: "Black Color Laptop",
      currentPrice: 52999.00,
      oldPrice: 70000.00,
      discount: "-32%",
      image:
          "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "How to Win Friends and Influence People",
      currentPrice: 396.00,
      oldPrice: 700.00,
      discount: "-77%",
      image: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Storio Soft Toy Unicorn Plushie – Soft Cuddly Toy",
      currentPrice: 358.00,
      oldPrice: 600.00,
      discount: "-68%",
      image:
          "https://images.unsplash.com/photo-1587402092301-725e37c70fd8?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Luxury Gold Plated Smartwatch",
      currentPrice: 499.99,
      oldPrice: 699.99,
      discount: "-40%",
      image:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Aerofit Spin Bike AF-780 (Yellow/Black) – 12 kg...",
      currentPrice: 34499.00,
      oldPrice: 42999.00,
      discount: "-25%",
      image:
          "https://images.unsplash.com/photo-1517649763962-0c623066013b?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Wireless Noise Cancelling Headphones",
      currentPrice: 2999.00,
      oldPrice: 5999.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFCE4EC),
            Color.fromARGB(255, 245, 156, 187),
            Color.fromARGB(255, 215, 157, 225),
            Color(0xFFD1C4E9),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated bubbles
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: _BubblePainter(_animationController.value),
                child: Container(),
              );
            },
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30,
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "New Arrivals",
                        style: TextStyle(
                          fontSize: 28,
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
                      for (
                        int i = 0;
                        i < 5 && startIdx + i < products.length;
                        i++
                      ) {
                        pageProducts.add(products[startIdx + i]);
                      }

                      return Row(
                        children: pageProducts.map((product) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: _DesktopNewArrivalCard(product: product),
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
                  children: List.generate((products.length / 5).ceil(), (
                    index,
                  ) {
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
            ),
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

class _DesktopNewArrivalCard extends StatefulWidget {
  final ProductItem product;

  const _DesktopNewArrivalCard({required this.product});

  @override
  State<_DesktopNewArrivalCard> createState() => _DesktopNewArrivalCardState();
}

class _DesktopNewArrivalCardState extends State<_DesktopNewArrivalCard> {
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
                  // Discount Badge
                  Positioned(
                    top: 12,
                    left: 12,
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
                    top: 12,
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

// Custom painter for floating bubbles
class _BubblePainter extends CustomPainter {
  final double animation;

  _BubblePainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw multiple bubbles with different sizes and positions
    _drawBubble(canvas, size, paint, 0.1, 0.2, 60, animation);
    _drawBubble(canvas, size, paint, 0.8, 0.3, 80, animation + 0.3);
    _drawBubble(canvas, size, paint, 0.3, 0.6, 50, animation + 0.5);
    _drawBubble(canvas, size, paint, 0.7, 0.7, 70, animation + 0.7);
    _drawBubble(canvas, size, paint, 0.5, 0.4, 90, animation + 0.2);
    _drawBubble(canvas, size, paint, 0.2, 0.8, 55, animation + 0.9);
  }

  void _drawBubble(
    Canvas canvas,
    Size size,
    Paint paint,
    double xRatio,
    double yRatio,
    double radius,
    double animOffset,
  ) {
    // Calculate position with animation
    final x = size.width * xRatio;
    final y = size.height * yRatio + (animOffset % 1.0) * 50 - 25;

    // Create gradient for bubble
    paint.shader = RadialGradient(
      colors: [
        Colors.white.withOpacity(0.3),
        Colors.white.withOpacity(0.1),
        Colors.transparent,
      ],
      stops: const [0.0, 0.7, 1.0],
    ).createShader(Rect.fromCircle(center: Offset(x, y), radius: radius));

    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  @override
  bool shouldRepaint(_BubblePainter oldDelegate) => true;
}
