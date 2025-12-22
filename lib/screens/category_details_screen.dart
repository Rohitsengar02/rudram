import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/data_models.dart';
import '../widgets/product_card.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final products = _getCategoryProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(
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
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }

  List<ProductItem> _getCategoryProducts() {
    final List<String> productImages = [
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/4_a7e9t3.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg",
    ];

    return List.generate(12, (index) {
      final imageIndex = index % productImages.length;

      return ProductItem(
        title: "$categoryName ${index + 1}",
        currentPrice: 25000 + (index * 5000),
        oldPrice: 30000 + (index * 5000),
        discount: "${10 + (index % 5)}% Off",
        image: productImages[imageIndex],
        bgColor: _getCategoryColor(index),
      );
    });
  }

  Color _getCategoryColor(int index) {
    final colors = [
      const Color(0xFFF5F5F5),
      const Color(0xFFFFF8DC),
      const Color(0xFFE8E8E8),
      const Color(0xFFE0F7FA),
      const Color(0xFFFFF3E0),
      const Color(0xFFF3E5F5),
    ];
    return colors[index % colors.length];
  }
}
