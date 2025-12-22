import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ExclusiveOffersBanner extends StatefulWidget {
  const ExclusiveOffersBanner({super.key});

  @override
  State<ExclusiveOffersBanner> createState() => _ExclusiveOffersBannerState();
}

class _ExclusiveOffersBannerState extends State<ExclusiveOffersBanner>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;
  AnimationController? _scaleController;
  AnimationController? _rotateController;

  final List<OfferData> _offers = [
    OfferData(
      title: "MEGA SALE",
      subtitle: "Upto 50% OFF on Wedding Collection",
      image:
          "https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800",
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D), Color(0xFFFF6B6B)],
      ),
    ),
    OfferData(
      title: "BUY 1 GET 1",
      subtitle: "On All Diamond Rings Collection",
      image:
          "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800",
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFF667EEA)],
      ),
    ),
    OfferData(
      title: "FESTIVE OFFER",
      subtitle: "Flat 30% OFF on All Necklaces",
      image:
          "https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800",
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF093FB), Color(0xFFF5576C), Color(0xFFF093FB)],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < _offers.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    _scaleController?.dispose();
    _rotateController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Simple breakpoint
        bool isDesktop = constraints.maxWidth > 600;
        double bannerHeight = isDesktop ? 400 : 194;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                    color: AppColors.primaryOrange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Exclusive Offers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: bannerHeight,
              child: PageView.builder(
                controller: _pageController,
                padEnds: false, // Ensure full width usage if valid
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _offers.length,
                itemBuilder: (context, index) {
                  return _buildOfferBanner(_offers[index]);
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _offers.length,
                (index) => _buildDot(index),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOfferBanner(OfferData offer) {
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleController, _rotateController]),
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.network(
                    offer.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(gradient: offer.gradient),
                      );
                    },
                  ),
                ),

                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                ),

                // Animated decorative circles
                Positioned(
                  right: -40,
                  top: -40,
                  child: Transform.scale(
                    scale: 1 + ((_scaleController?.value ?? 0) * 0.2),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: -30,
                  bottom: -30,
                  child: Transform.rotate(
                    angle: (_rotateController?.value ?? 0) * 6.28,
                    child: Icon(
                      Icons.card_giftcard,
                      size: 100,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),

                // Content
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            offer.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          offer.subtitle,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 10),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.textDark,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 5,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Shop Now",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryOrange
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
        boxShadow: _currentPage == index
            ? [
                BoxShadow(
                  color: AppColors.primaryOrange.withValues(alpha: 0.5),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
    );
  }
}

class OfferData {
  final String title;
  final String subtitle;
  final String image;
  final LinearGradient gradient;

  OfferData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.gradient,
  });
}
