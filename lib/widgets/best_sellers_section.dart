import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../utils/app_colors.dart';
import 'product_card.dart';

class BestSellersSection extends StatelessWidget {
  BestSellersSection({super.key});

  final List<ProductItem> products = [
    ProductItem(
      title: "Kundan Bridal Set",
      currentPrice: 245000,
      oldPrice: 289000,
      discount: "15% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg",
      bgColor: const Color(0xFFB8860B), // Dark goldenrod
    ),
    ProductItem(
      title: "Diamond Tennis Bracelet",
      currentPrice: 165000,
      oldPrice: 195000,
      discount: "15% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg",
      bgColor: const Color(0xFFCD7F32), // Bronze
    ),
    ProductItem(
      title: "Emerald Drop Earrings",
      currentPrice: 89000,
      oldPrice: 105000,
      discount: "15% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg",
      bgColor: const Color(0xFF50C878), // Emerald
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.primaryOrange, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    "Best Sellers",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
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
