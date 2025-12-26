import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'desktop_product_card.dart';

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
                      child: DesktopProductCard(product: product),
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
