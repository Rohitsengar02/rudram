import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class DesktopHeroBanner extends StatefulWidget {
  const DesktopHeroBanner({super.key});

  @override
  State<DesktopHeroBanner> createState() => _DesktopHeroBannerState();
}

class _DesktopHeroBannerState extends State<DesktopHeroBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<DesktopBannerItem> _banners = [
    DesktopBannerItem(
      title: "Enhance Your",
      highlightTitle: "Entertainment",
      subtitle: "Last call for up to ",
      discount: "20% off!",
      badgeText: "WEEKEND DISCOUNT",
      imageUrl: "assets/images/banner_3.png",
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.black, Colors.transparent],
      ),
      textColor: Colors.white,
    ),
    DesktopBannerItem(
      title: "New Season",
      highlightTitle: "Arrivals",
      subtitle: "Check out the latest ",
      discount: "Trends!",
      badgeText: "NEW COLLECTION",
      imageUrl: "assets/images/banner_1.jpg",
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.black, Colors.transparent],
      ),
      textColor: Colors.white,
      useAssetImage: true,
    ),
    DesktopBannerItem(
      title: "Smart",
      highlightTitle: "Lifestyle",
      subtitle: "Get smart with ",
      discount: "Gadgets",
      badgeText: "TECH DEALS",
      imageUrl: "assets/images/banner_2.png",
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.black, Colors.transparent],
      ),
      textColor: Colors.white,
      useAssetImage: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 70% of screen height as requested, minus some padding if needed,
    // but user asked for "hero section in 70vh".
    double height = MediaQuery.of(context).size.height * 0.7;

    return Container(
      height: height,
      margin: const EdgeInsets.only(left: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _banners.length,
              itemBuilder: (context, index) {
                return _buildBannerContent(_banners[index]);
              },
            ),
          ),

          // Indicators
          Positioned(
            bottom: 30, // Adjusted to not overlap with text bottom content
            right: 40, // Moved to right for better visibility with bottom text
            child: Row(
              children: List.generate(
                _banners.length,
                (index) => _buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerContent(DesktopBannerItem banner) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: banner.gradient),
      child: Stack(
        children: [
          // Image - Full Cover
          Positioned.fill(
            child: banner.useAssetImage
                ? Image.asset(banner.imageUrl, fit: BoxFit.cover)
                : Image.network(banner.imageUrl, fit: BoxFit.cover),
          ),

          // No gradient or text as requested
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryOrange : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class DesktopBannerItem {
  final String title;
  final String highlightTitle;
  final String subtitle;
  final String discount;
  final String badgeText;
  final String imageUrl;
  final LinearGradient gradient;
  final Color textColor;
  final bool useAssetImage;

  DesktopBannerItem({
    required this.title,
    required this.highlightTitle,
    required this.subtitle,
    required this.discount,
    required this.badgeText,
    required this.imageUrl,
    required this.gradient,
    required this.textColor,
    this.useAssetImage = false,
  });
}
