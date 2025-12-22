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
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg",
      bgColor: const Color(0xFFFFF8DC), // Cream
    ),
    ProductItem(
      title: "Gold Chain Necklace",
      currentPrice: 68500,
      oldPrice: 80000,
      discount: "15% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg",
      bgColor: const Color(0xFFFFD700), // Gold
    ),
    ProductItem(
      title: "Diamond Studs",
      currentPrice: 95000,
      oldPrice: 118000,
      discount: "20% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg",
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
