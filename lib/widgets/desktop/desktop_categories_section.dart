import 'package:flutter/material.dart';
import '../../screens/desktop/desktop_category_products_page.dart';

class DesktopCategoriesSection extends StatelessWidget {
  const DesktopCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Necklace Sets',
        'items': '250+ items',
        'icon': Icons.brightness_7_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774694/necklace_fuicra.png',
      },
      {
        'title': 'Earrings',
        'items': '500+ items',
        'icon': Icons.album_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774694/earrings_cbp4ay.png',
      },
      {
        'title': 'Gold Rings',
        'items': '180+ items',
        'icon': Icons.circle_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774693/ring_vcnnve.png',
      },
      {
        'title': 'Bangles',
        'items': '120+ items',
        'icon': Icons.adjust_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774693/holding-hands_fnhthw.png',
      },
      {
        'title': 'Bracelets',
        'items': '95+ items',
        'icon': Icons.all_out_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774693/bracelet_vlsdjb.png',
      },
      {
        'title': 'Pendants',
        'items': '150+ items',
        'icon': Icons.pentagon_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774693/pendant_zoy3sh.png',
      },
      {
        'title': 'Nose Pins',
        'items': '60+ items',
        'icon': Icons.grain_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774692/necklace_1_wzk1bs.png',
      },
      {
        'title': 'Mangalsutras',
        'items': '110+ items',
        'icon': Icons.auto_awesome_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774693/jewelry_qexcwa.png',
      },
      {
        'title': 'Gold Coins',
        'items': '30+ items',
        'icon': Icons.monetization_on_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774692/coins_p8bqjy.png',
      },
      {
        'title': 'Silver Jewellery',
        'items': '200+ items',
        'icon': Icons.diamond_outlined,
        'imageUrl':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1766774693/medal_ssqxlf.png',
      },
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Expanded(
                child: _buildCategoryItem(context, categories[index]),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Row(
            children: List.generate(
              5,
              (index) => Expanded(
                child: _buildCategoryItem(context, categories[index + 5]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    Map<String, dynamic> category,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DesktopCategoryProductsPage(categoryTitle: category['title']!),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category['title']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category['items']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: category['imageUrl'] != null
                  ? Image.network(
                      category['imageUrl']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        category['icon'] as IconData,
                        color: const Color(0xFF4F46E5),
                        size: 24,
                      ),
                    )
                  : Icon(
                      category['icon'] as IconData,
                      color: const Color(0xFF4F46E5),
                      size: 24,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
