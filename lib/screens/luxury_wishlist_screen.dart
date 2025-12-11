import 'package:flutter/material.dart';

class LuxuryWishlistScreen extends StatelessWidget {
  const LuxuryWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "YOUR CURATION",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Playfair Display',
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "4 ITEMS",
                    style: TextStyle(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
                      letterSpacing: 2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Image.network(
                              "https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=500", // Placeholder
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            const Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(
                                Icons.favorite,
                                color: Color(0xFFD4AF37),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Royal Emerald Set",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Playfair Display',
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "₹ 1,20,000",
                        style: TextStyle(color: Color(0xFFD4AF37)),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          minimumSize: const Size(0, 32),
                        ),
                        child: const Text(
                          "Move to Bag",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
