import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ShopByOccasionSection extends StatelessWidget {
  const ShopByOccasionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final occasions = [
      {
        'title': 'Wedding',
        'icon': Icons.favorite,
        'image':
            'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=400',
        'color': const Color(0xFFFFE4E1),
      },
      {
        'title': 'Anniversary',
        'icon': Icons.cake,
        'image':
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400',
        'color': const Color(0xFFE6E6FA),
      },
      {
        'title': 'Birthday',
        'icon': Icons.celebration,
        'image':
            'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=400',
        'color': const Color(0xFFFFF0F5),
      },
      {
        'title': 'Festive',
        'icon': Icons.auto_awesome,
        'image':
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400',
        'color': const Color(0xFFFFEFD5),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Shop by Occasion",
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
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: occasions.length,
            itemBuilder: (context, index) {
              final occasion = occasions[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        occasion['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: occasion['color'] as Color);
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.3),
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              occasion['icon'] as IconData,
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              occasion['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
