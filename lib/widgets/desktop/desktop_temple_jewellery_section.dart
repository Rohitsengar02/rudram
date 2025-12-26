import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../screens/shop_screen.dart';

class DesktopTempleJewellerySection extends StatelessWidget {
  const DesktopTempleJewellerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
            "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg", // Using a rich image for background
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ROYAL TEMPLE COLLECTION',
                style: TextStyle(
                  color: AppColors.primaryOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Divine Craftsmanship for the Modern Goddess',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  fontFamily:
                      'Playfair Display', // Assuming font usage or generic serif
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Inspired by the ancient temples of South India, our collection features intricate designs handcrafted with devotion and precision. Experience the divinity in every detail.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 25,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      0,
                    ), // Sharp edges for regal look
                  ),
                ),
                child: const Text(
                  'DISCOVER COLLECTION',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
