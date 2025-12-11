import 'package:flutter/material.dart';
import 'luxury_product_details_screen.dart';

class LuxuryShopScreen extends StatefulWidget {
  const LuxuryShopScreen({super.key});

  @override
  State<LuxuryShopScreen> createState() => _LuxuryShopScreenState();
}

class _LuxuryShopScreenState extends State<LuxuryShopScreen> {
  final List<String> _categories = [
    "All",
    "Necklaces",
    "Rings",
    "Bridal",
    "Watches",
    "Men's",
  ];
  int _selectedCategory = 0;

  // Real Images for Grid
  final List<String> _gridImages = [
    "https://images.unsplash.com/photo-1626177196020-f13110de832a?w=500",
    "https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=500",
    "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500",
    "https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=500",
    "https://images.unsplash.com/photo-1599643477877-53135397e209?w=500",
    "https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=500",
    "https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?w=500",
    "https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?w=500",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "THE COLLECTION",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Playfair Display',
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Categories
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategory == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFD4AF37)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey[800]!,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Products Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                ),
                itemCount: _gridImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LuxuryProductDetailsScreen(index: index),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                _gridImages[index],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Royal Heritage Item $index",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Playfair Display',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "₹ 4,50,000",
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontSize: 14,
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
      ),
    );
  }
}
