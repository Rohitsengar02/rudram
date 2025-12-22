import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/data_models.dart';
import '../quick_view_dialog.dart';
import 'dart:async';

class DesktopDealsOfTheDaySection extends StatefulWidget {
  const DesktopDealsOfTheDaySection({super.key});

  @override
  State<DesktopDealsOfTheDaySection> createState() =>
      _DesktopDealsOfTheDaySectionState();
}

class _DesktopDealsOfTheDaySectionState
    extends State<DesktopDealsOfTheDaySection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _current = 0;

  // Countdown timer
  late Timer _timer;
  Duration _timeRemaining = const Duration(hours: 23, minutes: 59, seconds: 59);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining.inSeconds > 0) {
          _timeRemaining = Duration(seconds: _timeRemaining.inSeconds - 1);
        } else {
          _timeRemaining = const Duration(hours: 23, minutes: 59, seconds: 59);
        }
      });
    });
  }

  final List<ProductItem> deals = [
    ProductItem(
      title: "Premium Leather Bag",
      currentPrice: 2499.00,
      oldPrice: 4999.00,
      discount: "-50%",
      image: "https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Wireless Gaming Mouse",
      currentPrice: 1299.00,
      oldPrice: 2599.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1527814050087-3793815479db?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Smart LED Bulb Pack",
      currentPrice: 899.00,
      oldPrice: 1799.00,
      discount: "-50%",
      image: "https://images.unsplash.com/photo-1550985616-10810253b84d?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Yoga Mat Premium",
      currentPrice: 599.00,
      oldPrice: 1199.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Stainless Steel Water Bottle",
      currentPrice: 399.00,
      oldPrice: 799.00,
      discount: "-50%",
      image:
          "https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange.shade50, Colors.white],
        ),
      ),
      child: Column(
        children: [
          // Header with Timer
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
                          "Deals of the Day",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E2832),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6B00), Color(0xFFFF8E00)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.flash_on,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${_timeRemaining.inHours.toString().padLeft(2, '0')}:${(_timeRemaining.inMinutes % 60).toString().padLeft(2, '0')}:${(_timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFeatures: [FontFeature.tabularFigures()],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Limited time offers - Grab them before they're gone!",
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
            itemCount: (deals.length / 4).ceil(),
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
            itemBuilder: (context, pageIndex, realIndex) {
              final startIdx = pageIndex * 4;
              final itemsInPage = <ProductItem>[];

              for (int i = 0; i < 4 && startIdx + i < deals.length; i++) {
                itemsInPage.add(deals[startIdx + i]);
              }

              return Row(
                children: itemsInPage.map((deal) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _DealCard(product: deal),
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
            children: List.generate((deals.length / 4).ceil(), (index) {
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
                        ? const Color(0xFFFF6B00)
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

class _DealCard extends StatefulWidget {
  final ProductItem product;

  const _DealCard({required this.product});

  @override
  State<_DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<_DealCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -10.0 : 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? const Color(0xFFFF6B00) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 10 : 5),
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
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    child: Image.network(
                      widget.product.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B00), Color(0xFFFF8E00)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.product.discount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
                          size: 20,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E2832),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "₹${widget.product.currentPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6B00),
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
    );
  }
}
