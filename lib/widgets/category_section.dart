import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../utils/app_colors.dart';

import '../screens/category_details_screen.dart';
import '../screens/categories_screen.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final ScrollController _scrollController = ScrollController();

  final List<CategoryItem> categories = [
    CategoryItem(
      title: "Electronic",
      icon: Icons.desktop_windows_outlined,
      color: Colors.blue.shade50,
    ),
    CategoryItem(
      title: "Games",
      icon: Icons.sports_esports_outlined,
      color: Colors.green.shade50,
    ),
    CategoryItem(
      title: "Fashion",
      icon: Icons.checkroom_outlined,
      color: Colors.pink.shade50,
    ),
    CategoryItem(
      title: "Pharmacy",
      icon: Icons.medical_services_outlined,
      color: Colors.cyan.shade50,
    ),
    CategoryItem(
      title: "Fast Food",
      icon: Icons.restaurant_outlined,
      color: Colors.yellow.shade50,
    ),

    CategoryItem(
      title: "Gadgets",
      icon: Icons.phone_android_outlined,
      color: Colors.purple.shade50,
    ),
    CategoryItem(
      title: "Accessories",
      icon: Icons.headphones_outlined,
      color: Colors.orange.shade50,
    ),
    CategoryItem(
      title: "Health",
      icon: Icons.favorite_outline,
      color: Colors.red.shade50,
    ),
    CategoryItem(
      title: "Beauty",
      icon: Icons.spa_outlined,
      color: Colors.purple.shade50,
    ),
    CategoryItem(
      title: "Drinks",
      icon: Icons.local_cafe_outlined,
      color: Colors.brown.shade50,
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Split categories into 2 rows
    final int itemsPerRow = (categories.length / 2).ceil();
    final List<CategoryItem> firstRow = categories.take(itemsPerRow).toList();
    final List<CategoryItem> secondRow = categories.skip(itemsPerRow).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
                child: const Text(
                  "See all",
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Two rows of categories with synchronized scrolling
        SizedBox(
          height: 206, // Height for both rows + spacing
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: itemsPerRow,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _buildCategoryItem(firstRow[index], index),
                  const SizedBox(height: 12),
                  if (index < secondRow.length)
                    _buildCategoryItem(secondRow[index], index + itemsPerRow),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(CategoryItem category, int globalIndex) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryDetailsScreen(categoryName: category.title),
          ),
        );
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  category.icon,
                  color: _getIconColor(globalIndex),
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor(int index) {
    final colors = [
      const Color(0xFF2196F3),
      const Color(0xFF4CAF50),
      const Color(0xFFE91E63),
      const Color(0xFF00BCD4),
      const Color(0xFFFFC107),
      const Color(0xFF9C27B0),
      const Color(0xFFFF9800),
      const Color(0xFFF44336),
      const Color(0xFF673AB7),
      const Color(0xFF795548),
    ];
    return colors[index % colors.length];
  }
}
