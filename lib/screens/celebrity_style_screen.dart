import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/app_colors.dart';
import 'celebrity_products_screen.dart';

class CelebrityStyleScreen extends StatelessWidget {
  const CelebrityStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = [
      {
        'title': 'Red Carpet',
        'image':
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
        'desc': 'Glamorous looks for the big night',
      },
      {
        'title': 'Bollywood',
        'image':
            'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=500',
        'desc': 'Desi vibes & traditional elegance',
      },
      {
        'title': 'Met Gala',
        'image':
            'https://images.unsplash.com/photo-1546167889-0b4d5ff30be0?w=500',
        'desc': 'Avant-garde & bold statements',
      },
      {
        'title': 'Cannes',
        'image':
            'https://images.unsplash.com/photo-1616091216791-a5360b5fc78a?w=500',
        'desc': 'French riviera sophistication',
      },
      {
        'title': 'Airport Look',
        'image':
            'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=500',
        'desc': 'Chic & comfortable travel styles',
      },
      {
        'title': 'Wedding Guest',
        'image':
            'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500',
        'desc': 'Perfect attire for celebrations',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          "Celebrity Style",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: styles.length,
          itemBuilder: (context, index) {
            final style = styles[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CelebrityProductsScreen(
                            celebrityName: style['title']!,
                            imageUrl: style['image']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(style['image']!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              style['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              style['desc']!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
