import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/data_models.dart';
import '../widgets/product_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic dummy data for preview
    final List<ProductItem> allProducts = [
      ProductItem(
        title: "Gold Necklace",
        currentPrice: 50000,
        oldPrice: 55000,
        discount: "10% Off",
        image:
            "https://images.unsplash.com/photo-1599643478518-17488fbbcd75?w=500",
        bgColor: const Color(0xFFFFF0E5),
      ),
      ProductItem(
        title: "Diamond Ring",
        currentPrice: 80000,
        oldPrice: 90000,
        discount: "12% Off",
        image:
            "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500",
        bgColor: const Color(0xFFF5F5F5),
      ),
      // Add more items logic later
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shop All",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: allProducts[index]);
        },
      ),
    );
  }
}
