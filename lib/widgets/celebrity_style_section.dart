import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CelebrityStyleSection extends StatelessWidget {
  const CelebrityStyleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = [
      {
        'title': 'Red Carpet',
        'image':
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
      },
      {
        'title': 'Bollywood',
        'image':
            'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=500',
      },
      {
        'title': 'Met Gala',
        'image':
            'https://images.unsplash.com/photo-1546167889-0b4d5ff30be0?w=500',
      },
      {
        'title': 'Cannes',
        'image':
            'https://images.unsplash.com/photo-1616091216791-a5360b5fc78a?w=500',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.star_border, color: AppColors.primaryOrange, size: 24),
              const SizedBox(width: 8),
              const Text(
                "Celebrity Style",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: styles.length,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        styles[index]['image']!,
                        height: 220,
                        width: 160,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey[300]),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Text(
                        styles[index]['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
