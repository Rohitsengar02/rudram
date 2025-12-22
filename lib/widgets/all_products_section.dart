import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../utils/app_colors.dart';

class AllProductsSection extends StatelessWidget {
  AllProductsSection({super.key});

  final List<String> _productImages = [
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/4_a7e9t3.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg",
  ];

  late final List<ProductItem> products = List.generate(12, (index) {
    String image = _productImages[index % _productImages.length];

    if (index % 4 == 0) {
      return ProductItem(
        title: "Gold Necklace Design $index",
        currentPrice: 45000 + (index * 1000),
        oldPrice: 50000 + (index * 1000),
        discount: "10% Off",
        image: image,
        bgColor: const Color(0xFFFFD700),
      );
    } else if (index % 4 == 1) {
      return ProductItem(
        title: "Diamond Ring $index",
        currentPrice: 85000 + (index * 2000),
        oldPrice: 95000 + (index * 2000),
        discount: "12% Off",
        image: image,
        bgColor: const Color(0xFFC0C0C0),
      );
    } else if (index % 4 == 2) {
      return ProductItem(
        title: "Pearl Earrings $index",
        currentPrice: 25000 + (index * 500),
        oldPrice: 30000 + (index * 500),
        discount: "15% Off",
        image: image,
        bgColor: const Color(0xFFFFF8DC),
      );
    } else {
      return ProductItem(
        title: "Bracelet $index",
        currentPrice: 65000 + (index * 1500),
        oldPrice: 75000 + (index * 1500),
        discount: "8% Off",
        image: image,
        bgColor: const Color(0xFFDAA520),
      );
    }
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            "All Products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildGridProductItem(products[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGridProductItem(ProductItem product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        // ProductCard removal of start background
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: product.bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: product.image.isNotEmpty
                    ? Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      )
                    : const Icon(Icons.image),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "₹${product.currentPrice}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "₹${product.oldPrice}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
