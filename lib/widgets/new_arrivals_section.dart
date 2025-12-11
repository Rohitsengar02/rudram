import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../utils/app_colors.dart';
import 'product_card.dart';

class NewArrivalsSection extends StatelessWidget {
  NewArrivalsSection({super.key});

  final List<ProductItem> products = [
    ProductItem(
      title: "Pearl Earring Set",
      currentPrice: 42500,
      oldPrice: 57900,
      discount: "30% Off",
      image:
          "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=500",
      bgColor: const Color(0xFFFFF8DC), // Cream
    ),
    ProductItem(
      title: "Gold Chain Necklace",
      currentPrice: 68500,
      oldPrice: 80000,
      discount: "15% Off",
      image:
          "https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500",
      bgColor: const Color(0xFFFFD700), // Gold
    ),
    ProductItem(
      title: "Diamond Studs",
      currentPrice: 95000,
      oldPrice: 118000,
      discount: "20% Off",
      image:
          "https://images.unsplash.com/photo-1535556116002-6281ff3e9f35?w=500",
      bgColor: const Color(0xFFE8E8E8), // Light grey
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "New Arrivals",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "See all",
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),

        // List
        SizedBox(
          height: 270,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ),
      ],
    );
  }
}
