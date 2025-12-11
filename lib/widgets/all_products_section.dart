import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../utils/app_colors.dart';

class AllProductsSection extends StatelessWidget {
  AllProductsSection({super.key});

  final List<ProductItem> products = List.generate(10, (index) {
    if (index % 4 == 0) {
      return ProductItem(
        title: "Gold Necklace Design $index",
        currentPrice: 45000 + (index * 1000),
        oldPrice: 50000 + (index * 1000),
        discount: "10% Off",
        image:
            "https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500",
        bgColor: const Color(0xFFFFD700),
      );
    } else if (index % 4 == 1) {
      return ProductItem(
        title: "Diamond Ring $index",
        currentPrice: 85000 + (index * 2000),
        oldPrice: 95000 + (index * 2000),
        discount: "12% Off",
        image:
            "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500",
        bgColor: const Color(0xFFC0C0C0),
      );
    } else if (index % 4 == 2) {
      return ProductItem(
        title: "Pearl Earrings $index",
        currentPrice: 25000 + (index * 500),
        oldPrice: 30000 + (index * 500),
        discount: "15% Off",
        image:
            "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=500",
        bgColor: const Color(0xFFFFF8DC),
      );
    } else {
      return ProductItem(
        title: "Bracelet $index",
        currentPrice: 65000 + (index * 1500),
        oldPrice: 75000 + (index * 1500),
        discount: "8% Off",
        image:
            "https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=500",
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.62, // Adjusted for ProductCard height
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              // ProductCard is designed for horizontal list, might need tweaks or use as is
              // ProductCard has fixed width 180, here width is flexible.
              // Let's wrap ProductCard to just use its visual build but flexible width.
              // Actually ProductCard has explicit width: 180. We need to make it flexible?
              // Or better, creating a simple grid item here or modify ProductCard.
              // Since ProductCard is StatelessWidget with fixed width, using it in GridView might cause issues or alignment.
              // But let's try to just return the ProductCard content effectively.
              // Actually, looking at ProductCard, it has Container width: 180.
              // I will create a localized grid item here to ensure good look.
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
          Row(
            children: [
              Text(
                "₹${product.currentPrice}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "₹${product.oldPrice}",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textGrey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
