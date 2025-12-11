import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Gold',
        'image':
            'https://images.unsplash.com/photo-1610375499862-acb4a8a0a9f6?w=200',
      },
      {
        'name': 'Diamond',
        'image':
            'https://images.unsplash.com/photo-1617038224558-28ad3fb558a7?w=200',
      },
      {
        'name': 'Silver',
        'image':
            'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=200',
      },
      {
        'name': 'Platinum',
        'image':
            'https://images.unsplash.com/photo-1626947346165-4c2288ba210b?w=200',
      },
      {
        'name': 'Gemstones',
        'image':
            'https://images.unsplash.com/photo-1600003014755-ba31aa59c4b6?w=200',
      },
      {
        'name': 'Coins',
        'image':
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=200',
      },
    ];

    return Scaffold(
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
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to CategoryDetails
              Navigator.pushNamed(
                context,
                '/category_details',
                arguments: categories[index]['name'],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(categories[index]['image']!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  categories[index]['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
