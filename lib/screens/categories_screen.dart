import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'category_details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _sidebarItems = [
    {'title': 'For You', 'icon': Icons.thumb_up_alt_outlined},
    {'title': 'Books', 'icon': Icons.menu_book_outlined},
    {'title': 'Kitchen', 'icon': Icons.kitchen_outlined},
    {'title': 'Tools', 'icon': Icons.handyman_outlined},
    {'title': 'Kids', 'icon': Icons.child_care_outlined},
    {'title': 'Muslim', 'icon': Icons.mosque_outlined},
    {'title': 'Men', 'icon': Icons.man_outlined},
    {'title': 'Women', 'icon': Icons.woman_outlined},
    {'title': 'Music', 'icon': Icons.music_note_outlined},
    {'title': 'Gaming', 'icon': Icons.videogame_asset_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar
          Container(
            width: 90,
            color: const Color(0xFFF5F5F5),
            child: ListView.builder(
              itemCount: _sidebarItems.length,
              itemBuilder: (context, index) {
                return _buildSidebarItem(index);
              },
            ),
          ),

          // Main Content
          Expanded(child: _buildCategoryContent()),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        color: isSelected ? Colors.white : const Color(0xFFF5F5F5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            // Indicator if selected (Left border visual trick could be done with Stack, but simple bg change is often enough or a colored icon)
            Icon(
              _sidebarItems[index]['icon'],
              color: isSelected ? AppColors.primaryOrange : Colors.grey[600],
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              _sidebarItems[index]['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.primaryOrange : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent() {
    // In a real app, switch content based on _selectedIndex
    // For now, mirroring the "For You" layout from the image for index 0
    // Others can show generic grid
    if (_selectedIndex != 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _sidebarItems[_selectedIndex]['icon'],
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              "Products for ${_sidebarItems[_selectedIndex]['title']}",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "What's Trending",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            _buildTrendingCard(
              "Kitchen",
              "https://images.unsplash.com/photo-1556910103-1c02745a30bf?w=400",
              Colors.orange,
            ),
            _buildTrendingCard(
              "Men's Fashion",
              "https://images.unsplash.com/photo-1490114538077-0a7f8cb49891?w=400",
              Colors.blue,
            ),
            _buildTrendingCard(
              "Women's Fashion",
              "https://images.unsplash.com/photo-1550614000-4b9519e02d2c?w=400",
              Colors.pinkAccent,
            ),
            _buildTrendingCard(
              "Mom & Baby",
              "https://images.unsplash.com/photo-1519689680058-324335c77eba?w=400",
              Colors.green,
            ),
            _buildTrendingCard(
              "Computers",
              "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400",
              const Color(0xFF1E88E5),
            ),
            _buildTrendingCard(
              "Food & Drink",
              "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400",
              Colors.deepOrange,
              isTall: false, // The image showed tall, but grid is simpler
            ),
          ],
        ),

        const SizedBox(height: 24),
        const Text(
          "Often Viewed",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75, // Taller for product cards
          children: [
            _buildProductItem(
              "Accessories",
              "https://images.unsplash.com/photo-1615663245857-acda6a983424?w=200",
            ),
            _buildProductItem(
              "Gaming",
              "https://images.unsplash.com/photo-1526509867162-5b0c0d1b4b33?w=200",
            ),
            _buildProductItem(
              "Mini PC",
              "https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=200",
            ),
            _buildProductItem(
              "Monitors",
              "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=200",
            ),
            _buildProductItem(
              "Networking",
              "https://images.unsplash.com/photo-1544197150-b99a580bbcbf?w=200",
            ),
            _buildProductItem(
              "Laptops",
              "https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=200",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendingCard(
    String title,
    String imageUrl,
    Color bgColor, {
    bool isTall = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(categoryName: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Background Pattern or Gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Image
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              bottom: 40,
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (c, e, s) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            // Text
            Positioned(
              bottom: 12,
              left: 8,
              right: 8,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(categoryName: title),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}
