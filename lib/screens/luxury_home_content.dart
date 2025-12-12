import 'dart:async';
import 'package:flutter/material.dart';
import 'watch_and_shop_screen.dart';

class LuxuryHomeContent extends StatefulWidget {
  const LuxuryHomeContent({super.key});

  @override
  State<LuxuryHomeContent> createState() => _LuxuryHomeContentState();
}

class _LuxuryHomeContentState extends State<LuxuryHomeContent> {
  final PageController _heroController = PageController();
  final PageController _masterpieceController = PageController(
    viewportFraction: 0.85,
  );
  int _currentHeroPage = 0;
  Timer? _heroTimer;
  Timer? _masterpieceTimer;

  // Real Image URLs
  final List<String> _heroImages = [
    "https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800",
    "https://images.unsplash.com/photo-1588880331179-bc9b93a8cb5e?w=800",
    "https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=800",
  ];

  final List<String> _jewelImages = [
    "https://images.unsplash.com/photo-1626177196020-f13110de832a?w=400",
    "https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=400",
    "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=400",
    "https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=400",
    "https://images.unsplash.com/photo-1599643477877-53135397e209?w=400",
    "https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400",
    "https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?w=400",
    "https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?w=400",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _heroTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_heroController.hasClients) {
        int nextPage = _currentHeroPage + 1;
        if (nextPage >= _heroImages.length) nextPage = 0;
        _heroController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        setState(() => _currentHeroPage = nextPage);
      }
    });

    _masterpieceTimer = Timer.periodic(const Duration(seconds: 5), (
      Timer timer,
    ) {
      if (_masterpieceController.hasClients) {
        _masterpieceController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _heroTimer?.cancel();
    _masterpieceTimer?.cancel();
    _heroController.dispose();
    _masterpieceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "L U X U R Y",
          style: TextStyle(color: Colors.white, letterSpacing: 4, fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false, // Managed by parent or none
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Space for bottom bar
        child: Column(
          children: [
            // 1. Hero Parallax Carousel
            SizedBox(
              height: 500,
              child: PageView.builder(
                controller: _heroController,
                itemCount: _heroImages.length,
                onPageChanged: (idx) => setState(() => _currentHeroPage = idx),
                itemBuilder: (context, index) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        _heroImages[index],
                        fit: BoxFit.cover,
                        color: Colors.black.withValues(alpha: 0.3),
                        colorBlendMode: BlendMode.darken,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "COLLECTION No. ${index + 1}",
                              style: const TextStyle(
                                color: Color(0xFFD4AF37),
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "ROYAL HERITAGE",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Playfair Display',
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 2. Categories
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                children: [
                  _buildCategoryItem(
                    "Solitaires",
                    "https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=200",
                  ),
                  _buildCategoryItem(
                    "Watches",
                    "https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=200",
                  ),
                  _buildCategoryItem(
                    "Necklaces",
                    "https://images.unsplash.com/photo-1599643478518-17488fbbcd75?w=200",
                  ),
                  _buildCategoryItem(
                    "Rings",
                    "https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=200",
                  ),
                  _buildCategoryItem(
                    "Bracelets",
                    "https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=200",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Watch & Shop Banner
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WatchAndShopScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: DecorationImage(
                    image: const NetworkImage(
                      "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=800",
                    ), // Gradient or abstract luxury background
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.3),
                      BlendMode.darken,
                    ),
                  ),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 48,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "WATCH & SHOP",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Playfair Display',
                          fontSize: 24,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        "Experience jewellery in motion",
                        style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // 3. Masterpieces Auto Carousel
            _buildSectionHeader("Masterpieces"),
            SizedBox(
              height: 420,
              child: PageView.builder(
                controller: _masterpieceController,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              _jewelImages[index % _jewelImages.length],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "The Royal Set ${index + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Playfair Display',
                            fontSize: 24,
                          ),
                        ),
                        const Text(
                          "₹ 25,00,000",
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 4. Limited Edition (Updated)
            const SizedBox(height: 48),
            _buildSectionHeader("Limited Edition"),
            _buildProductList(offset: 2),

            // 5. High Jewellery Gallery
            const SizedBox(height: 48),
            _buildSectionHeader("High Jewellery Gallery"),
            SizedBox(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 6,
                itemBuilder: (context, index) => Container(
                  width: 260,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          _jewelImages[(index + 4) % _jewelImages.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Emerald & Diamond",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Playfair Display',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 6. Royal Banner
            const SizedBox(height: 64),
            _buildBannerSection(
              "Royal Collections",
              "https://images.unsplash.com/photo-1589674781759-c21c37956a44?w=800",
              "Inspired by the Maharajas",
            ),

            // 7. Vintage Classics
            const SizedBox(height: 48),
            _buildSectionHeader("Vintage Classics"),
            _buildProductList(offset: 1),

            // 8. Men's Royal
            const SizedBox(height: 48),
            _buildSectionHeader("Men's Royal Access"),
            _buildProductList(offset: 4),

            // 9. Solitaire Lounge Banner
            const SizedBox(height: 64),
            _buildBannerSection(
              "Solitaire Lounge",
              "https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=800",
              "Forever yours",
            ),

            // 10. Platinum Edit
            const SizedBox(height: 48),
            _buildSectionHeader("The Platinum Edit"),
            _buildProductList(offset: 0),

            // 11. Rare Gemstones Banner (Fixed URL)
            const SizedBox(height: 64),
            _buildBannerSection(
              "Rare Gemstones",
              "https://images.unsplash.com/photo-1599643478518-17488fbbcd75?w=800",
              "Sapphires, Emeralds & Rubies",
            ),

            // 12. Investment Grade
            const SizedBox(height: 48),
            _buildSectionHeader("Investment Grade"),
            _buildProductList(offset: 5),

            // 13. Gold Vault Banner (Fixed URL)
            const SizedBox(height: 64),
            _buildBannerSection(
              "The Gold Vault",
              "https://images.unsplash.com/photo-1626177196020-f13110de832a?w=800",
              "24K Pure Gold",
            ), // Fixed from broken URL
            // 14. Bridal Trousseau
            const SizedBox(height: 48),
            _buildSectionHeader("Bridal Trousseau"),
            _buildProductList(offset: 2),

            // 15. Statement Rings
            const SizedBox(height: 48),
            _buildSectionHeader("Statement Cocktail Rings"),
            _buildProductList(offset: 6),

            // 16. Temple Heritage
            const SizedBox(height: 48),
            _buildSectionHeader("Temple Heritage"),
            _buildProductList(offset: 7),

            // 17. Designers
            const SizedBox(height: 48),
            _buildSectionHeader("Designer Collaborations"),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildDesignerCard(
                    "Sabyasachi",
                    "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400",
                  ),
                  _buildDesignerCard(
                    "Manish Malhotra",
                    "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFD4AF37),
                fontFamily: 'Playfair Display',
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 8),
            Container(width: 40, height: 1, color: const Color(0xFFD4AF37)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imgUrl) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: const Color(0xFFD4AF37)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLuxuryProductCard(int index, String image) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Imperial Item #$index",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Playfair Display',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "₹ 1,50,000",
            style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList({int offset = 0}) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (context, index) => _buildLuxuryProductCard(
          index,
          _jewelImages[(index + offset) % _jewelImages.length],
        ),
      ),
    );
  }

  Widget _buildBannerSection(String title, String image, String sub) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Playfair Display',
              fontSize: 32,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            sub,
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 1.5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text("DISCOVER"),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignerCard(String name, String image) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.4),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Playfair Display',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
