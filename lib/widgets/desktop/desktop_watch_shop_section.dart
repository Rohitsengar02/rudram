import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../screens/shop_screen.dart';
import '../../screens/desktop/desktop_product_details_screen.dart';
import '../../models/data_models.dart';

class DesktopWatchShopSection extends StatelessWidget {
  const DesktopWatchShopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
      color: Colors.white,
      child: Column(
        children: [
          // Section Header
          const Text(
            'Premium Watch Collection',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Timeless pieces that define sophistication',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 60),
          // Watch Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildWatchCard(context, index); // Pass context
            },
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'View All Watches',
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

  Widget _buildWatchCard(BuildContext context, int index) {
    final watches = [
      {
        'name': 'Classic Elegance',
        'price': '45000',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg',
      },
      {
        'name': 'Modern Luxury',
        'price': '65000',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/4_a7e9t3.jpg',
      },
      {
        'name': 'Royal Heritage',
        'price': '85000',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg',
      },
      {
        'name': 'Diamond Elite',
        'price': '95000',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg',
      },
      {
        'name': 'Gold Prestige',
        'price': '75000',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg',
      },
      {
        'name': 'Platinum Series',
        'price': '125000',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg',
      },
    ];

    final watch = watches[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DesktopProductDetailsScreen(
              product: ProductItem(
                title: watch['name']!,
                currentPrice: double.parse(watch['price']!),
                oldPrice: (double.parse(watch['price']!) * 1.2),
                discount: "20% Off",
                image: watch['image']!,
                bgColor: Colors.white,
              ),
            ),
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      watch['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.watch, size: 60),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Details
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      watch['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₹${watch['price']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
