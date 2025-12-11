import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class LuxurySection extends StatelessWidget {
  const LuxurySection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Diamond Solitaire',
        'price': '₹4,50,000',
        'image':
            'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500',
      },
      {
        'title': 'Platinum Band',
        'price': '₹3,25,000',
        'image':
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=500',
      },
      {
        'title': 'Emerald Necklace',
        'price': '₹5,75,000',
        'image':
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500',
      },
    ];

    return Container(
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.diamond, color: AppColors.primaryOrange, size: 24),
                const SizedBox(width: 8),
                const Text(
                  "Luxury Collection",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 274,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryOrange.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          product['image']!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              color: const Color(0xFF3A3A3A),
                              child: const Icon(
                                Icons.diamond,
                                size: 60,
                                color: Colors.white24,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product['price']!,
                              style: TextStyle(
                                color: AppColors.primaryOrange,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
