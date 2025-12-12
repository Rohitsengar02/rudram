import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'reels_screen.dart';

class WatchAndShopScreen extends StatelessWidget {
  const WatchAndShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Watch & Shop",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(
                "Curated Collections",
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Playfair Display',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildCollectionCarousel(context, "Trending Now", [
              _CollectionItem(
                "Royal Wedding",
                "https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=600",
              ),
              _CollectionItem(
                "Diamond Gala",
                "https://images.unsplash.com/photo-1588880331179-bc9b93a8cb5e?w=600",
              ),
              _CollectionItem(
                "Vintage Charm",
                "https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=600",
              ),
            ]),

            const SizedBox(height: 32),
            _buildCollectionCarousel(context, "New Arrivals", [
              _CollectionItem(
                "Summer Sparkle",
                "https://images.unsplash.com/photo-1626177196020-f13110de832a?w=600",
              ),
              _CollectionItem(
                "Gold Rush",
                "https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=600",
              ),
              _CollectionItem(
                "Platinum Edit",
                "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=600",
              ),
            ]),

            const SizedBox(height: 32),
            _buildCollectionCarousel(context, "Editor's Picks", [
              _CollectionItem(
                "Statement Rings",
                "https://images.unsplash.com/photo-1600080972464-8e5f35f63d88?w=600",
              ),
              _CollectionItem(
                "Bridal Sets",
                "https://images.unsplash.com/photo-1599643477877-53135397e209?w=600",
              ),
            ]),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionCarousel(
    BuildContext context,
    String title,
    List<_CollectionItem> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "See all",
                style: TextStyle(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReelsScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 180,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(items[index].imageUrl, fit: BoxFit.cover),
                        Container(
                          decoration: BoxDecoration(
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
                          bottom: 16,
                          left: 12,
                          right: 12,
                          child: Text(
                            items[index].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
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

class _CollectionItem {
  final String title;
  final String imageUrl;
  _CollectionItem(this.title, this.imageUrl);
}
