import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CommunityGallerySection extends StatelessWidget {
  const CommunityGallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    // 6 images for gallery
    final images = [
      'https://images.unsplash.com/photo-1596919796030-ea5c4fa10688?w=300',
      'https://images.unsplash.com/photo-1585123380276-88b13c32e303?w=300',
      'https://images.unsplash.com/photo-1589156229687-496a31ad1d1f?w=300',
      'https://images.unsplash.com/photo-1616091216791-a5360b5fc78a?w=300',
      'https://images.unsplash.com/photo-1606293926075-69a00fb03689?w=300',
      'https://images.unsplash.com/photo-1601055283738-f938d227b6b1?w=300',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "#RudramCommunity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Upload Your Look",
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[300]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
