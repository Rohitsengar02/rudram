import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class DesktopInstaFamilySection extends StatelessWidget {
  const DesktopInstaFamilySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            '#RudramFamily',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Join our community of style icons. Tag us to be featured!',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 50),
          // Insta Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.0,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: 5, // 5 images in a row
            itemBuilder: (context, index) {
              return _buildInstaPost(index);
            },
          ),
          const SizedBox(height: 40),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Follow Us @RudramJewels'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textDark,
              side: const BorderSide(color: AppColors.textDark),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstaPost(int index) {
    final images = [
      'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg',
      'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg',
      'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg',
      'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg',
      'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg',
    ];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(images[index % images.length]),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
            ),
          ),
          child: const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.favorite, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
