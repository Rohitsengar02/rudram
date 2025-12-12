import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/data_models.dart';
import '../utils/app_colors.dart';
import 'product_details_screen.dart';

class CelebrityProductsScreen extends StatelessWidget {
  final String celebrityName;
  final String imageUrl;

  CelebrityProductsScreen({
    super.key,
    required this.celebrityName,
    required this.imageUrl,
  });

  // Mock Data matching the celebrity theme
  final List<ProductItem> products = [
    ProductItem(
      title: "Red Carpet Necklace",
      currentPrice: 125000,
      oldPrice: 150000,
      discount: "15% Off",
      image:
          "https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500",
      bgColor: const Color(0xFFFFF8DC),
    ),
    ProductItem(
      title: "Diamond Drop Earrings",
      currentPrice: 45000,
      oldPrice: 55000,
      discount: "18% Off",
      image:
          "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=500",
      bgColor: const Color(0xFFF5F5F5),
    ),
    ProductItem(
      title: "Luxury Bracelet",
      currentPrice: 85000,
      oldPrice: 95000,
      discount: "10% Off",
      image:
          "https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=500",
      bgColor: const Color(0xFFE0F7FA),
    ),
    ProductItem(
      title: "Ruby Pendant",
      currentPrice: 65000,
      oldPrice: 72000,
      discount: "10% Off",
      image:
          "https://images.unsplash.com/photo-1600721391776-b560d7306910?w=500",
      bgColor: const Color(0xFFFFEBEE),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(imageUrl, fit: BoxFit.cover),
              title: Text(
                celebrityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Trends worn by $celebrityName",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: AnimationLimiter(
              child: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        // Use local flexible card to prevent overflow in grid
                        child: _CelebrityProductCard(product: products[index]),
                      ),
                    ),
                  );
                }, childCount: products.length),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }
}

class _CelebrityProductCard extends StatelessWidget {
  final ProductItem product;

  const _CelebrityProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        // Remove fixed width/margin for Grid
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack - Flexible Height
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: product.bgColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: product.image.isNotEmpty
                          ? Hero(
                              tag: "${product.title}_celeb",
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.diamond,
                                size: 80,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                    ),
                  ),
                  // Discount Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.discount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Wishlist Icon
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Text Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "₹${product.currentPrice}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "₹${product.oldPrice}",
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
