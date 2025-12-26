import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/data_models.dart';
import '../../screens/shop_screen.dart';
import '../../screens/desktop/desktop_product_details_screen.dart';
import '../../widgets/product_card.dart';

class DesktopAllProductsSection extends StatelessWidget {
  const DesktopAllProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
      color: const Color(0xFFF9F9F9),
      child: Column(
        children: [
          const Text(
            'Explore Our Collection',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Discover jewelry that resonates with your soul',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 50),

          _buildProductsGrid(),

          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'View All Products',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    final List<String> productImages = [
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/4_a7e9t3.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg",
      "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg",
      "https://images.unsplash.com/photo-1626784215032-2e3916fda07e?w=500",
      "https://images.unsplash.com/photo-1600721391776-b560d7306910?w=500",
    ];

    final products = List.generate(8, (index) {
      final imageIndex = index % productImages.length;
      return ProductItem(
        title: "Premium Jewelry Item ${index + 1}",
        currentPrice: 45000 + (index * 5000),
        oldPrice: 55000 + (index * 5000),
        discount: "10% Off",
        image: productImages[imageIndex],
        bgColor: Colors.white,
      );
    });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 items per row on desktop
        childAspectRatio: 0.7,
        crossAxisSpacing: 30,
        mainAxisSpacing: 40,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DesktopProductDetailsScreen(product: products[index]),
              ),
            );
          },
          child: ProductCard(product: products[index]),
        );
      },
    );
  }
}
